import * as dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
dotenv.config();

import fs from 'fs';
import path from 'path';
import bcrypt from 'bcryptjs';
import { db } from './index';
import * as schema from './schema';
import { eq } from 'drizzle-orm';

async function seed() {
  console.log('🌱 Starting database seeding...');

  // 1. Business settings
  const existingSettings = await db.select().from(schema.businessSettings).limit(1);
  if (existingSettings.length === 0) {
    const settingsId = '00000000-0000-0000-0000-000000000001';
    await db.insert(schema.businessSettings).values({
      id: settingsId,
      shopName: 'Bazar Bari',
      address: 'House #12, Road #4, Dhanmondi, Dhaka-1205',
      phone: '01700000000',
      email: 'info@bazarbari.com',
      currencySymbol: '৳',
      currencyCode: 'BDT',
      vatRate: '0.00',
      receiptHeader: 'বাজার বাড়ি - অনলাইন ও অফলাইন গ্রোসারি',
      receiptFooter: 'আমাদের সাথে থাকার জন্য ধন্যবাদ!',
    });
    console.log('✓ Business settings seeded');
  }

  // 2. Main Branch
  let mainBranchId = '00000000-0000-0000-0000-000000000002';
  const existingBranches = await db.select().from(schema.branches).limit(1);
  if (existingBranches.length === 0) {
    await db.insert(schema.branches).values({
      id: mainBranchId,
      name: 'Main Store',
      code: 'MAIN',
      phone: '01700000000',
      address: 'Dhanmondi, Dhaka',
      isMain: true,
      isActive: true,
    });
    console.log('✓ Main branch seeded');
  } else {
    mainBranchId = existingBranches[0].id;
  }

  // 3. Super Admin User (admin / admin123)
  const existingAdmin = await db.select().from(schema.users).where(eq(schema.users.username, 'admin')).limit(1);
  let adminUserId = '00000000-0000-0000-0000-000000000003';
  if (existingAdmin.length === 0) {
    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash('admin123', salt);
    await db.insert(schema.users).values({
      id: adminUserId,
      name: 'Super Admin',
      username: 'admin',
      email: 'admin@bazarbari.local',
      phone: '01711111111',
      passwordHash,
      userType: 'staff',
      role: 'super_admin',
      branchId: mainBranchId,
      isActive: true,
    });
    await db.insert(schema.profiles).values({
      id: adminUserId,
      fullName: 'Super Admin',
      username: 'admin',
      phone: '01711111111',
      branchId: mainBranchId,
    });
    await db.insert(schema.userRoles).values({
      id: crypto.randomUUID(),
      userId: adminUserId,
      role: 'super_admin',
    });
    console.log('✓ Super admin seeded (username: admin, password: admin123)');
  } else {
    adminUserId = existingAdmin[0].id;
  }

  // 4. Default Cash & Bank Accounts
  const existingAccounts = await db.select().from(schema.accounts).limit(1);
  if (existingAccounts.length === 0) {
    await db.insert(schema.accounts).values([
      {
        id: crypto.randomUUID(),
        name: 'Cash Register (Main)',
        type: 'cash',
        branchId: mainBranchId,
        openingBalance: '5000.00',
        currentBalance: '5000.00',
        note: 'Default cash counter till',
      },
      {
        id: crypto.randomUUID(),
        name: 'bKash Merchant',
        type: 'mobile_money',
        accountNumber: '01700000001',
        branchId: mainBranchId,
        openingBalance: '0.00',
        currentBalance: '0.00',
      },
    ]);
    console.log('✓ Financial accounts seeded');
  }

  // 5. Default Units
  const existingUnits = await db.select().from(schema.units).limit(1);
  if (existingUnits.length === 0) {
    await db.insert(schema.units).values([
      { id: crypto.randomUUID(), name: 'Piece', code: 'pcs' },
      { id: crypto.randomUUID(), name: 'Kilogram', code: 'kg' },
      { id: crypto.randomUUID(), name: 'Gram', code: 'g' },
      { id: crypto.randomUUID(), name: 'Liter', code: 'ltr' },
    ]);
    console.log('✓ Units seeded');
  }

  // 6. Extracted Data from Supabase
  const extractedPath = path.resolve(process.cwd(), 'scripts/extracted_supabase_data.json');
  if (fs.existsSync(extractedPath)) {
    const raw = fs.readFileSync(extractedPath, 'utf-8');
    const data = JSON.parse(raw);

    // Categories
    if (Array.isArray(data.categories)) {
      for (const cat of data.categories) {
        const existing = await db.select().from(schema.categories).where(eq(schema.categories.id, cat.id)).limit(1);
        if (existing.length === 0) {
          const slug = cat.name_en.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
          await db.insert(schema.categories).values({
            id: cat.id,
            nameEn: cat.name_en,
            nameBn: cat.name_bn,
            slug,
            isActive: true,
          });
        }
      }
      console.log(`✓ Seeded ${data.categories.length} categories from Supabase`);
    }

    // Delivery zones
    if (Array.isArray(data.delivery_zones)) {
      for (const zone of data.delivery_zones) {
        const existing = await db.select().from(schema.deliveryZones).where(eq(schema.deliveryZones.id, zone.id)).limit(1);
        if (existing.length === 0) {
          await db.insert(schema.deliveryZones).values({
            id: zone.id,
            nameEn: zone.name_en,
            nameBn: zone.name_bn,
            deliveryFee: String(zone.delivery_fee || 0),
            minOrder: String(zone.min_order || 0),
            freeDeliveryAbove: zone.free_delivery_above ? String(zone.free_delivery_above) : null,
            etaMinutes: zone.eta_minutes || 60,
            isActive: zone.is_active ?? true,
          });
        }
      }
      console.log(`✓ Seeded ${data.delivery_zones.length} delivery zones from Supabase`);
    }

    // Products
    if (Array.isArray(data.products)) {
      let count = 0;
      for (const prod of data.products) {
        const existing = await db.select().from(schema.products).where(eq(schema.products.id, prod.id)).limit(1);
        if (existing.length === 0) {
          await db.insert(schema.products).values({
            id: prod.id,
            nameEn: prod.name_en,
            nameBn: prod.name_bn,
            sku: prod.sku || `SKU-${count + 1000}`,
            barcode: prod.barcode || null,
            categoryId: prod.category_id || null,
            brand: prod.brand || 'Local',
            unit: prod.unit || 'pcs',
            packSize: prod.pack_size || null,
            costPrice: String(prod.cost || 0),
            price: String(prod.price || 0),
            stock: Number(prod.stock || 0),
            alertQuantity: Number(prod.low_stock_at || 5),
            imageUrl: prod.image_url || null,
            seq: prod.seq || count,
            isActive: prod.is_active ?? true,
          });

          // Branch stock
          await db.insert(schema.productStock).values({
            id: crypto.randomUUID(),
            productId: prod.id,
            branchId: mainBranchId,
            stock: Number(prod.stock || 0),
            costPrice: String(prod.cost || 0),
          });
          count++;
        }
      }
      console.log(`✓ Seeded ${count} products & branch stock records from Supabase`);
    }
  }

  console.log('🎉 Database seeding complete!');
  process.exit(0);
}

seed().catch((err) => {
  console.error('❌ Seeding failed:', err);
  process.exit(1);
});
