import { NextRequest, NextResponse } from 'next/server';
import { db } from '@/db';
import { users, profiles } from '@/db/schema';
import bcrypt from 'bcryptjs';
import { eq } from 'drizzle-orm';

export async function POST(req: NextRequest) {
  try {
    const { phone, pin, name } = await req.json();

    const rawPhone = String(phone).replace(/\D/g, '');
    const cleanPhone = rawPhone.startsWith('880') ? `0${rawPhone.slice(3)}` : rawPhone;

    const existing = await db
      .select()
      .from(users)
      .where(eq(users.phone, cleanPhone))
      .limit(1);

    if (existing.length > 0) {
      return NextResponse.json({ error: 'This phone number is already registered' }, { status: 400 });
    }

    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash(String(pin), salt);
    const userId = crypto.randomUUID();

    await db.insert(users).values({
      id: userId,
      name: name || `Customer ${cleanPhone.slice(-4)}`,
      phone: cleanPhone,
      email: `${cleanPhone}@shopper.yesspos.app`,
      passwordHash,
      userType: 'customer',
      role: 'customer',
      isActive: true,
    });

    await db.insert(profiles).values({
      id: userId,
      fullName: name || `Customer ${cleanPhone.slice(-4)}`,
      phone: cleanPhone,
    });

    return NextResponse.json({
      success: true,
      user: { id: userId, phone: cleanPhone, name },
    });
  } catch (err: any) {
    return NextResponse.json({ error: err.message || 'Registration failed' }, { status: 500 });
  }
}
