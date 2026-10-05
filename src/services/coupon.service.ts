import { db } from '@/db';
import * as schema from '@/db/schema';
import { eq, and, sql } from 'drizzle-orm';

export async function validateCoupon(code: string, subtotal: number) {
  const cleanCode = code.trim().toUpperCase();
  const list = await db
    .select()
    .from(schema.coupons)
    .where(and(eq(schema.coupons.code, cleanCode), eq(schema.coupons.isActive, true)))
    .limit(1);

  const coupon = list[0];
  if (!coupon) return { valid: false, message: 'Invalid or expired coupon' };

  if (coupon.expiresOn) {
    const exp = new Date(coupon.expiresOn);
    if (new Date() > exp) return { valid: false, message: 'Coupon expired' };
  }

  const minAmt = Number(coupon.minAmount || 0);
  if (subtotal < minAmt) {
    return { valid: false, message: `Minimum order amount is ৳${minAmt}` };
  }

  if (coupon.usageLimit && (coupon.usageCount || 0) >= coupon.usageLimit) {
    return { valid: false, message: 'Coupon usage limit reached' };
  }

  let discount = 0;
  const val = Number(coupon.value);
  if (coupon.type === 'percent') {
    discount = (subtotal * val) / 100;
    if (coupon.maxDiscount && discount > Number(coupon.maxDiscount)) {
      discount = Number(coupon.maxDiscount);
    }
  } else {
    discount = Math.min(val, subtotal);
  }

  return {
    valid: true,
    discount,
    code: coupon.code,
    type: coupon.type,
    value: val,
  };
}

export async function bumpCouponUsage(code: string) {
  await db
    .update(schema.coupons)
    .set({ usageCount: sql`${schema.coupons.usageCount} + 1` })
    .where(eq(schema.coupons.code, code.trim().toUpperCase()));
}
