import { db } from '@/db';
import * as schema from '@/db/schema';
import { eq, sql } from 'drizzle-orm';

export const REDEEM_MIN_POINTS = 1000;
export const POINTS_PER_CURRENCY = 10; // 10 points = ৳1

export async function getMemberLoyalty(phone: string) {
  const normPhone = phone.trim();
  const contact = await db
    .select()
    .from(schema.contacts)
    .where(eq(schema.contacts.phone, normPhone))
    .limit(1);

  if (contact.length === 0) return { exists: false, points: 0 };
  return { exists: true, contact: contact[0], points: contact[0].loyaltyPoints || 0 };
}

export async function applyLoyaltyTransaction(
  phone: string,
  subtotal: number,
  redeemPoints: number = 0,
  saleId?: string
) {
  const normPhone = phone.trim();
  const earned = Math.floor(subtotal / 10); // 10 points per ৳100

  let contactList = await db
    .select()
    .from(schema.contacts)
    .where(eq(schema.contacts.phone, normPhone))
    .limit(1);

  let contact = contactList[0];
  if (!contact) {
    const newId = crypto.randomUUID();
    await db.insert(schema.contacts).values({
      id: newId,
      name: `Member (${normPhone.slice(-4)})`,
      phone: normPhone,
      type: 'customer',
      loyaltyPoints: 0,
    });
    contactList = await db
      .select()
      .from(schema.contacts)
      .where(eq(schema.contacts.id, newId))
      .limit(1);
    contact = contactList[0];
  }

  const currentPoints = contact.loyaltyPoints || 0;
  const actualRedeem = Math.min(currentPoints, redeemPoints);
  const newBalance = Math.max(0, currentPoints - actualRedeem + earned);

  await db
    .update(schema.contacts)
    .set({ loyaltyPoints: newBalance })
    .where(eq(schema.contacts.id, contact.id));

  // Log in loyalty ledger
  await db.insert(schema.loyaltyLedger).values({
    id: crypto.randomUUID(),
    phone: normPhone,
    saleId: saleId || null,
    pointsEarned: earned,
    pointsRedeemed: actualRedeem,
    pointsBalance: newBalance,
    note: `Earned ${earned} pts on ৳${subtotal}, redeemed ${actualRedeem} pts`,
  });

  return {
    earned,
    redeemed: actualRedeem,
    discountAmount: actualRedeem / POINTS_PER_CURRENCY,
    newBalance,
  };
}
