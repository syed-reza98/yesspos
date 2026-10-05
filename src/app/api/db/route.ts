import { NextRequest, NextResponse } from 'next/server';
import { db } from '@/db';
import { tableMap, mapCamelToSnake, mapSnakeToCamel } from '@/db/tables';
import { eq, ne, gte, lte, lt, gt, desc, asc, like, and, or, inArray, sql } from 'drizzle-orm';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { table, action, select, filters = [], orders = [], limit, data } = body;

    const tableSchema = tableMap[table];
    if (!tableSchema) {
      return NextResponse.json({ error: `Table '${table}' not found` }, { status: 400 });
    }

    function normalizeVal(val: any) {
      if (val === null || val === undefined) return val;
      if (typeof val === 'string' && /^\d{4}-\d{2}-\d{2}/.test(val)) {
        const d = new Date(val);
        if (!isNaN(d.getTime())) return d;
      }
      return val;
    }

    function normalizeRow(obj: any) {
      const res: any = {};
      for (const [k, v] of Object.entries(obj)) {
        if (typeof v === 'string' && /^\d{4}-\d{2}-\d{2}(T|\s)/.test(v)) {
          const d = new Date(v);
          if (!isNaN(d.getTime())) {
            res[k] = d;
            continue;
          }
        }
        res[k] = v;
      }
      return res;
    }

    // 1. Build where conditions
    const conditions: any[] = [];
    for (const f of filters) {
      const colName = f.column.replace(/_([a-z0-9])/g, (_: any, l: string) => l.toUpperCase());
      const col = tableSchema[colName] || tableSchema[f.column];
      if (!col) continue;

      const normVal = normalizeVal(f.value);

      switch (f.op) {
        case 'eq':
          conditions.push(eq(col, normVal));
          break;
        case 'neq':
          conditions.push(ne(col, normVal));
          break;
        case 'gte':
          conditions.push(gte(col, normVal));
          break;
        case 'lte':
          conditions.push(lte(col, normVal));
          break;
        case 'gt':
          conditions.push(gt(col, normVal));
          break;
        case 'lt':
          conditions.push(lt(col, normVal));
          break;
        case 'like':
        case 'ilike':
          conditions.push(like(col, String(f.value).replace(/%/g, '%')));
          break;
        case 'in':
          if (Array.isArray(f.value) && f.value.length > 0) {
            conditions.push(inArray(col, f.value.map(normalizeVal)));
          }
          break;
      }
    }
    const whereClause = conditions.length > 0 ? and(...conditions) : undefined;

    // 2. Handle Actions
    if (action === 'select') {
      let query = db.select().from(tableSchema);
      if (whereClause) {
        query = query.where(whereClause) as any;
      }

      // Ordering
      for (const ord of orders) {
        const colName = ord.column.replace(/_([a-z0-9])/g, (_: any, l: string) => l.toUpperCase());
        const col = tableSchema[colName] || tableSchema[ord.column];
        if (col) {
          query = (ord.ascending ? query.orderBy(asc(col)) : query.orderBy(desc(col))) as any;
        }
      }

      if (limit) {
        query = query.limit(Number(limit)) as any;
      }

      const rows = await query;
      const formatted = rows.map((r: any) => mapCamelToSnake(r));
      return NextResponse.json({ data: formatted, error: null });
    }

    if (action === 'insert') {
      const insertData = Array.isArray(data) ? data : [data];
      const insertedRows: any[] = [];

      for (const row of insertData) {
        const mapped = normalizeRow(mapSnakeToCamel(row));
        if (!mapped.id) mapped.id = crypto.randomUUID();

        if (table === 'sales' && !mapped.invoiceNo) {
          const maxInvoice = await db.select({ max: sql`MAX(invoice_no)` }).from(tableSchema);
          const nextInvoice = Number(maxInvoice[0]?.max || 1000) + 1;
          mapped.invoiceNo = nextInvoice;
        }

        if (table === 'delivery_orders' && !mapped.orderNo) {
          const maxOrder = await db.select({ max: sql`MAX(order_no)` }).from(tableSchema);
          const nextOrder = Number(maxOrder[0]?.max || 5000) + 1;
          mapped.orderNo = nextOrder;
        }

        await db.insert(tableSchema).values(mapped);
        insertedRows.push(mapCamelToSnake(mapped));
      }

      return NextResponse.json({
        data: Array.isArray(data) ? insertedRows : insertedRows[0],
        error: null,
      });
    }

    if (action === 'update') {
      const mapped = normalizeRow(mapSnakeToCamel(data));
      delete mapped.id; // don't update ID
      let updateQuery = db.update(tableSchema).set(mapped);
      if (whereClause) {
        updateQuery = updateQuery.where(whereClause) as any;
      }
      await updateQuery;
      return NextResponse.json({ data: true, error: null });
    }

    if (action === 'delete') {
      let deleteQuery = db.delete(tableSchema);
      if (whereClause) {
        deleteQuery = deleteQuery.where(whereClause) as any;
      }
      await deleteQuery;
      return NextResponse.json({ data: true, error: null });
    }

    return NextResponse.json({ error: `Unsupported action '${action}'` }, { status: 400 });
  } catch (err: any) {
    console.error('[API /api/db Error]', err);
    return NextResponse.json({ error: err.message, data: null }, { status: 500 });
  }
}
