import { db } from '@/db';
import * as schema from '@/db/schema';
import { eq, sql, and } from 'drizzle-orm';

export async function adjustBranchStock(
  productId: string,
  branchId: string,
  delta: number
) {
  // Update or insert branch stock
  const existing = await db
    .select()
    .from(schema.productStock)
    .where(
      and(
        eq(schema.productStock.productId, productId),
        eq(schema.productStock.branchId, branchId)
      )
    )
    .limit(1);

  if (existing.length > 0) {
    const newStock = Math.max(0, existing[0].stock + delta);
    await db
      .update(schema.productStock)
      .set({ stock: newStock })
      .where(eq(schema.productStock.id, existing[0].id));
  } else {
    const initialStock = Math.max(0, delta);
    await db.insert(schema.productStock).values({
      id: crypto.randomUUID(),
      productId,
      branchId,
      stock: initialStock,
    });
  }

  // Sync total stock across all branches to the products table
  const totals = await db
    .select({
      total: sql<number>`COALESCE(SUM(${schema.productStock.stock}), 0)`,
    })
    .from(schema.productStock)
    .where(eq(schema.productStock.productId, productId));

  const totalStock = totals[0]?.total ?? 0;
  await db
    .update(schema.products)
    .set({ stock: totalStock })
    .where(eq(schema.products.id, productId));

  return totalStock;
}

export type CreateSaleInput = {
  branchId?: string;
  customerId?: string;
  customerName?: string;
  customerPhone?: string;
  subtotal: number;
  discount?: number;
  tax?: number;
  total: number;
  paid: number;
  due?: number;
  paymentMethod?: string;
  status?: string;
  userId?: string;
  items: Array<{
    productId: string;
    quantity: number;
    unitPrice: number;
    costPrice?: number;
    discount?: number;
    lineTotal: number;
    nameSnapshot: string;
  }>;
};

export async function createSale(data: CreateSaleInput) {
  const saleId = crypto.randomUUID();
  const invoiceNo = Date.now(); // millisecond sequence

  // 1. Insert sale record
  await db.insert(schema.sales).values({
    id: saleId,
    invoiceNo,
    branchId: data.branchId || null,
    customerId: data.customerId || null,
    customerName: data.customerName || 'Walk-in Customer',
    customerPhone: data.customerPhone || null,
    subtotal: String(data.subtotal),
    discount: String(data.discount || 0),
    tax: String(data.tax || 0),
    total: String(data.total),
    paid: String(data.paid),
    due: String(data.due || 0),
    paymentMethod: data.paymentMethod || 'cash',
    status: data.status || 'final',
    userId: data.userId || null,
  });

  // 2. Insert items and decrement stock
  for (const item of data.items) {
    await db.insert(schema.saleItems).values({
      id: crypto.randomUUID(),
      saleId,
      productId: item.productId,
      quantity: String(item.quantity),
      unitPrice: String(item.unitPrice),
      costPrice: String(item.costPrice || 0),
      discount: String(item.discount || 0),
      lineTotal: String(item.lineTotal),
      nameSnapshot: item.nameSnapshot,
    });

    if (data.status !== 'quotation' && data.branchId) {
      await adjustBranchStock(item.productId, data.branchId, -Math.ceil(item.quantity));
    }
  }

  return { id: saleId, invoiceNo };
}
