// Server-side Supabase client with lazy DB loading to prevent bundling mysql2 into client
import { tableMap, mapCamelToSnake, mapSnakeToCamel } from '@/db/tables';

async function getDb() {
  if (typeof window !== 'undefined') return null;
  const mod = await import('@/db');
  return mod.db;
}

class ServerQueryBuilder {
  private _table: string;
  private _tableSchema: any;
  private _filters: any[] = [];
  private _limitVal?: number;
  private _orders: any[] = [];

  constructor(table: string) {
    this._table = table;
    this._tableSchema = tableMap[table];
  }

  select(cols = '*', opts?: any) {
    return this;
  }

  eq(col: string, val: any) {
    if (this._tableSchema) {
      const colName = col.replace(/_([a-z0-9])/g, (_, l) => l.toUpperCase());
      const field = this._tableSchema[colName] || this._tableSchema[col];
      if (field) this._filters.push({ col: field, val, op: 'eq' });
    }
    return this;
  }

  neq(col: string, val: any) {
    return this;
  }

  lt(col: string, val: any) {
    return this;
  }

  limit(n: number) {
    this._limitVal = n;
    return this;
  }

  order(col: string, opts = { ascending: true }) {
    if (this._tableSchema) {
      const colName = col.replace(/_([a-z0-9])/g, (_, l) => l.toUpperCase());
      const field = this._tableSchema[colName] || this._tableSchema[col];
      if (field) this._orders.push({ field, ascending: opts.ascending });
    }
    return this;
  }

  async maybeSingle() {
    this._limitVal = 1;
    const res: any = await this;
    return { data: res?.data?.[0] || null, error: null };
  }

  async then(resolve: any, reject?: any) {
    try {
      const db = await getDb();
      if (!db || !this._tableSchema) {
        return resolve({ data: [], error: null });
      }

      const { eq, desc, and } = await import('drizzle-orm');
      let q = db.select().from(this._tableSchema);

      if (this._filters.length > 0) {
        const conditions = this._filters.map((f) => eq(f.col, f.val));
        q = q.where(and(...conditions)) as any;
      }
      for (const ord of this._orders) {
        q = (ord.ascending ? q.orderBy(ord.field) : q.orderBy(desc(ord.field))) as any;
      }
      if (this._limitVal) {
        q = q.limit(this._limitVal) as any;
      }
      const rows = await q;
      const formatted = rows.map((r: any) => mapCamelToSnake(r));
      return resolve({ data: formatted, error: null });
    } catch (err: any) {
      return resolve({ data: null, error: { message: err.message } });
    }
  }

  async insert(data: any) {
    const db = await getDb();
    const mapped = mapSnakeToCamel(data);
    if (!mapped.id) mapped.id = crypto.randomUUID();
    if (db && this._tableSchema) {
      await db.insert(this._tableSchema).values(mapped);
    }
    return { data: mapped, error: null };
  }

  async upsert(data: any, opts?: any) {
    return this.insert(data);
  }

  delete() {
    return {
      eq: async (col: string, val: any) => {
        const db = await getDb();
        if (db && this._tableSchema) {
          const { eq } = await import('drizzle-orm');
          const colName = col.replace(/_([a-z0-9])/g, (_, l) => l.toUpperCase());
          const field = this._tableSchema[colName] || this._tableSchema[col];
          if (field) await db.delete(this._tableSchema).where(eq(field, val));
        }
        return { data: true, error: null };
      },
    };
  }

  update(data: any) {
    return {
      eq: async (col: string, val: any) => {
        const db = await getDb();
        if (db && this._tableSchema) {
          const { eq } = await import('drizzle-orm');
          const colName = col.replace(/_([a-z0-9])/g, (_, l) => l.toUpperCase());
          const field = this._tableSchema[colName] || this._tableSchema[col];
          const mapped = mapSnakeToCamel(data);
          delete mapped.id;
          if (field) await db.update(this._tableSchema).set(mapped).where(eq(field, val));
        }
        return { data: true, error: null };
      },
    };
  }
}

export const supabaseAdmin: any = {
  from(table: string) {
    return new ServerQueryBuilder(table);
  },
  auth: {
    admin: {
      async createUser(data: any) {
        const id = crypto.randomUUID();
        return { data: { user: { id } }, error: null };
      },
      async updateUserById(id: string, data: any) {
        return { error: null };
      },
      async deleteUser(id: string) {
        return { error: null };
      },
    },
  },
};
