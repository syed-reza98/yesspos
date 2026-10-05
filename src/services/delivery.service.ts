import { db } from '@/db';
import * as schema from '@/db/schema';
import { eq, and, sql } from 'drizzle-orm';

export type CreateDeliveryOrderInput = {
  customerName: string;
  customerPhone: string;
  deliveryAddress: string;
  zoneId?: string;
  deliverySlot?: string;
  subtotal: number;
  deliveryFee: number;
  discount?: number;
  total: number;
  paymentMethod?: string;
  notes?: string;
  items: Array<{
    productId: string;
    productName: string;
    quantity: number;
    unitPrice: number;
    lineTotal: number;
  }>;
};

export async function createDeliveryOrder(data: CreateDeliveryOrderInput) {
  const orderId = crypto.randomUUID();
  const orderNo = Math.floor(100000 + Math.random() * 900000);

  await db.insert(schema.deliveryOrders).values({
    id: orderId,
    orderNo,
    customerName: data.customerName,
    customerPhone: data.customerPhone,
    deliveryAddress: data.deliveryAddress,
    zoneId: data.zoneId || null,
    deliverySlot: data.deliverySlot || null,
    subtotal: String(data.subtotal),
    deliveryFee: String(data.deliveryFee),
    discount: String(data.discount || 0),
    total: String(data.total),
    paymentMethod: data.paymentMethod || 'cod',
    paymentStatus: 'unpaid',
    status: 'pending',
    notes: data.notes || null,
  });

  for (const item of data.items) {
    await db.insert(schema.deliveryOrderItems).values({
      id: crypto.randomUUID(),
      deliveryOrderId: orderId,
      productId: item.productId,
      productName: item.productName,
      quantity: String(item.quantity),
      unitPrice: String(item.unitPrice),
      lineTotal: String(item.lineTotal),
    });
  }

  // Initial event
  await db.insert(schema.deliveryOrderEvents).values({
    id: crypto.randomUUID(),
    orderId,
    status: 'pending',
    notes: 'Order placed by customer',
    actor: data.customerName,
  });

  return { id: orderId, orderNo };
}

export async function trackOrder(orderNo: number, phone: string) {
  const normPhone = phone.trim();
  const orders = await db
    .select()
    .from(schema.deliveryOrders)
    .where(
      and(
        eq(schema.deliveryOrders.orderNo, orderNo),
        eq(schema.deliveryOrders.customerPhone, normPhone)
      )
    )
    .limit(1);

  if (orders.length === 0) return null;
  const order = orders[0];

  const items = await db
    .select()
    .from(schema.deliveryOrderItems)
    .where(eq(schema.deliveryOrderItems.deliveryOrderId, order.id));

  const events = await db
    .select()
    .from(schema.deliveryOrderEvents)
    .where(eq(schema.deliveryOrderEvents.orderId, order.id));

  let rider = null;
  if (order.riderId) {
    const riders = await db
      .select()
      .from(schema.deliveryRiders)
      .where(eq(schema.deliveryRiders.id, order.riderId))
      .limit(1);
    rider = riders[0] || null;
  }

  return { order, items, events, rider };
}
