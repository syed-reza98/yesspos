import {
  mysqlTable,
  varchar,
  text,
  int,
  decimal,
  boolean,
  timestamp,
  json,
  bigint,
  date,
} from 'drizzle-orm/mysql-core';
import { sql } from 'drizzle-orm';

// Helper for standard ID
export const uuidCol = (name = 'id') => varchar(name, { length: 36 });

// ==========================================
// 1. AUTH & USERS (Unified Staff & Customers)
// ==========================================
export const users = mysqlTable('users', {
  id: uuidCol('id').primaryKey(),
  name: varchar('name', { length: 120 }),
  username: varchar('username', { length: 60 }).unique(),
  email: varchar('email', { length: 191 }).unique(),
  phone: varchar('phone', { length: 30 }).unique(),
  passwordHash: varchar('password_hash', { length: 255 }),
  userType: varchar('user_type', { length: 20 }).default('staff').notNull(), // 'staff' | 'customer'
  role: varchar('role', { length: 30 }).default('staff').notNull(), // 'super_admin' | 'admin' | 'manager' | 'cashier' | 'staff' | 'customer'
  branchId: uuidCol('branch_id'),
  image: text('image'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const authAccounts = mysqlTable('auth_accounts', {
  id: uuidCol('id').primaryKey(),
  userId: uuidCol('user_id').notNull(),
  type: varchar('type', { length: 255 }).notNull(),
  provider: varchar('provider', { length: 255 }).notNull(),
  providerAccountId: varchar('provider_account_id', { length: 255 }).notNull(),
  refresh_token: text('refresh_token'),
  access_token: text('access_token'),
  expires_at: int('expires_at'),
  token_type: varchar('token_type', { length: 255 }),
  scope: varchar('scope', { length: 255 }),
  id_token: text('id_token'),
  session_state: varchar('session_state', { length: 255 }),
});

export const authSessions = mysqlTable('auth_sessions', {
  sessionToken: varchar('session_token', { length: 255 }).primaryKey(),
  userId: uuidCol('user_id').notNull(),
  expires: timestamp('expires').notNull(),
});

export const authVerificationTokens = mysqlTable('auth_verification_tokens', {
  identifier: varchar('identifier', { length: 255 }).notNull(),
  token: varchar('token', { length: 255 }).notNull(),
  expires: timestamp('expires').notNull(),
});

export const userRoles = mysqlTable('user_roles', {
  id: uuidCol('id').primaryKey(),
  userId: uuidCol('user_id').notNull(),
  role: varchar('role', { length: 30 }).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const profiles = mysqlTable('profiles', {
  id: uuidCol('id').primaryKey(), // maps to users.id
  fullName: varchar('full_name', { length: 120 }),
  username: varchar('username', { length: 60 }),
  phone: varchar('phone', { length: 30 }),
  branchId: uuidCol('branch_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

// ==========================================
// 2. TENANCY & GLOBAL SETTINGS
// ==========================================
export const businessSettings = mysqlTable('business_settings', {
  id: uuidCol('id').primaryKey(),
  shopName: varchar('shop_name', { length: 120 }).default('Bazar Bari').notNull(),
  address: text('address'),
  phone: varchar('phone', { length: 50 }),
  email: varchar('email', { length: 120 }),
  currencySymbol: varchar('currency_symbol', { length: 10 }).default('৳').notNull(),
  currencyCode: varchar('currency_code', { length: 10 }).default('BDT').notNull(),
  vatRate: decimal('vat_rate', { precision: 5, scale: 2 }).default('0.00'),
  receiptHeader: text('receipt_header'),
  receiptFooter: text('receipt_footer'),
  logoUrl: text('logo_url'),
  extra: json('extra'),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const branches = mysqlTable('branches', {
  id: uuidCol('id').primaryKey(),
  name: varchar('name', { length: 120 }).notNull(),
  code: varchar('code', { length: 30 }).unique(),
  phone: varchar('phone', { length: 50 }),
  address: text('address'),
  isMain: boolean('is_main').default(false).notNull(),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const siteContent = mysqlTable('site_content', {
  id: uuidCol('id').primaryKey(),
  key: varchar('key', { length: 100 }).unique().notNull(),
  label: varchar('label', { length: 150 }),
  valueBn: text('value_bn'),
  valueEn: text('value_en'),
  category: varchar('category', { length: 60 }).default('general'),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const apiSettings = mysqlTable('api_settings', {
  id: uuidCol('id').primaryKey(),
  provider: varchar('provider', { length: 60 }).notNull(), // 'sms' | 'payment' | etc.
  label: varchar('label', { length: 100 }).notNull(),
  category: varchar('category', { length: 60 }).default('gateway').notNull(),
  baseUrl: text('base_url'),
  apiKey: text('api_key'),
  apiSecret: text('api_secret'),
  senderId: varchar('sender_id', { length: 60 }),
  enabled: boolean('enabled').default(false).notNull(),
  notes: text('notes'),
  extra: json('extra'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const mediaAssets = mysqlTable('media_assets', {
  id: uuidCol('id').primaryKey(),
  name: varchar('name', { length: 255 }).notNull(),
  path: text('path'),
  url: text('url'),
  filePath: text('file_path'),
  fileType: varchar('file_type', { length: 60 }),
  fileSize: int('file_size'),
  folder: varchar('folder', { length: 100 }).default('general'),
  altText: varchar('alt_text', { length: 255 }),
  mimeType: varchar('mime_type', { length: 100 }),
  sizeBytes: int('size_bytes'),
  tags: json('tags'),
  width: int('width'),
  height: int('height'),
  variants: json('variants'),
  uploadedBy: uuidCol('uploaded_by'),
  deletedAt: timestamp('deleted_at'),
  deletedBy: uuidCol('deleted_by'),
  deletedUsage: json('deleted_usage'),
  category: varchar('category', { length: 60 }).default('general'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const auditLogs = mysqlTable('audit_logs', {
  id: uuidCol('id').primaryKey(),
  userId: uuidCol('user_id'),
  username: varchar('username', { length: 60 }),
  action: varchar('action', { length: 120 }).notNull(),
  entity: varchar('entity', { length: 60 }),
  entityId: varchar('entity_id', { length: 64 }),
  details: text('details'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

// ==========================================
// 3. CATALOG & PRODUCTS
// ==========================================
export const categories = mysqlTable('categories', {
  id: uuidCol('id').primaryKey(),
  nameEn: varchar('name_en', { length: 120 }).notNull(),
  nameBn: varchar('name_bn', { length: 120 }).notNull(),
  slug: varchar('slug', { length: 120 }).unique(),
  icon: varchar('icon', { length: 60 }),
  parentId: uuidCol('parent_id'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const brands = mysqlTable('brands', {
  id: uuidCol('id').primaryKey(),
  name: varchar('name', { length: 120 }).notNull(),
  description: text('description'),
  logoUrl: text('logo_url'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const units = mysqlTable('units', {
  id: uuidCol('id').primaryKey(),
  name: varchar('name', { length: 60 }).notNull(),
  code: varchar('code', { length: 30 }),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const products = mysqlTable('products', {
  id: uuidCol('id').primaryKey(),
  nameEn: varchar('name_en', { length: 255 }).notNull(),
  nameBn: varchar('name_bn', { length: 255 }).notNull(),
  sku: varchar('sku', { length: 100 }),
  barcode: varchar('barcode', { length: 100 }),
  categoryId: uuidCol('category_id'),
  brand: varchar('brand', { length: 120 }),
  unit: varchar('unit', { length: 30 }).default('pcs'),
  packSize: varchar('pack_size', { length: 60 }),
  costPrice: decimal('cost_price', { precision: 12, scale: 2 }).default('0.00'),
  price: decimal('price', { precision: 12, scale: 2 }).default('0.00').notNull(),
  mrp: decimal('mrp', { precision: 12, scale: 2 }),
  stock: int('stock').default(0).notNull(),
  alertQuantity: int('alert_quantity').default(5),
  imageUrl: text('image_url'),
  description: text('description'),
  seq: int('seq'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const productStock = mysqlTable('product_stock', {
  id: uuidCol('id').primaryKey(),
  productId: uuidCol('product_id').notNull(),
  branchId: uuidCol('branch_id').notNull(),
  stock: int('stock').default(0).notNull(),
  costPrice: decimal('cost_price', { precision: 12, scale: 2 }),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const productReviews = mysqlTable('product_reviews', {
  id: uuidCol('id').primaryKey(),
  productId: uuidCol('product_id').notNull(),
  customerName: varchar('customer_name', { length: 100 }).notNull(),
  customerPhone: varchar('customer_phone', { length: 30 }),
  rating: int('rating').default(5).notNull(),
  reviewText: text('review_text'),
  isApproved: boolean('is_approved').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

// ==========================================
// 4. SALES & POS
// ==========================================
export const sales = mysqlTable('sales', {
  id: uuidCol('id').primaryKey(),
  invoiceNo: bigint('invoice_no', { mode: 'number' }),
  branchId: uuidCol('branch_id'),
  customerId: uuidCol('customer_id'),
  customerName: varchar('customer_name', { length: 120 }),
  customerPhone: varchar('customer_phone', { length: 30 }),
  subtotal: decimal('subtotal', { precision: 12, scale: 2 }).default('0.00').notNull(),
  discount: decimal('discount', { precision: 12, scale: 2 }).default('0.00'),
  tax: decimal('tax', { precision: 12, scale: 2 }).default('0.00'),
  total: decimal('total', { precision: 12, scale: 2 }).default('0.00').notNull(),
  paid: decimal('paid', { precision: 12, scale: 2 }).default('0.00').notNull(),
  due: decimal('due', { precision: 12, scale: 2 }).default('0.00'),
  paymentMethod: varchar('payment_method', { length: 50 }).default('cash'),
  status: varchar('status', { length: 30 }).default('final').notNull(), // 'final' | 'quotation' | 'cancelled'
  notes: text('notes'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const saleItems = mysqlTable('sale_items', {
  id: uuidCol('id').primaryKey(),
  saleId: uuidCol('sale_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  quantity: decimal('quantity', { precision: 10, scale: 3 }).notNull(),
  unitPrice: decimal('unit_price', { precision: 12, scale: 2 }).notNull(),
  costPrice: decimal('cost_price', { precision: 12, scale: 2 }).default('0.00'),
  discount: decimal('discount', { precision: 12, scale: 2 }).default('0.00'),
  lineTotal: decimal('line_total', { precision: 12, scale: 2 }).notNull(),
  nameSnapshot: varchar('name_snapshot', { length: 255 }),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const saleReturns = mysqlTable('sale_returns', {
  id: uuidCol('id').primaryKey(),
  saleId: uuidCol('sale_id').notNull(),
  returnNo: varchar('return_no', { length: 60 }),
  branchId: uuidCol('branch_id'),
  refundAmount: decimal('refund_amount', { precision: 12, scale: 2 }).default('0.00').notNull(),
  reason: text('reason'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const saleReturnItems = mysqlTable('sale_return_items', {
  id: uuidCol('id').primaryKey(),
  saleReturnId: uuidCol('sale_return_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  quantity: decimal('quantity', { precision: 10, scale: 3 }).notNull(),
  unitPrice: decimal('unit_price', { precision: 12, scale: 2 }).notNull(),
  lineTotal: decimal('line_total', { precision: 12, scale: 2 }).notNull(),
});

export const userCarts = mysqlTable('user_carts', {
  id: uuidCol('id').primaryKey(),
  userId: uuidCol('user_id'),
  customerPhone: varchar('customer_phone', { length: 30 }),
  lines: json('lines'),
  items: json('items'),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

// ==========================================
// 5. PURCHASES & PROCUREMENT
// ==========================================
export const purchases = mysqlTable('purchases', {
  id: uuidCol('id').primaryKey(),
  purchaseNo: varchar('purchase_no', { length: 60 }),
  supplierId: uuidCol('supplier_id'),
  branchId: uuidCol('branch_id'),
  total: decimal('total', { precision: 12, scale: 2 }).default('0.00').notNull(),
  paid: decimal('paid', { precision: 12, scale: 2 }).default('0.00').notNull(),
  due: decimal('due', { precision: 12, scale: 2 }).default('0.00'),
  status: varchar('status', { length: 30 }).default('received').notNull(),
  purchaseDate: date('purchase_date'),
  notes: text('notes'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const purchaseItems = mysqlTable('purchase_items', {
  id: uuidCol('id').primaryKey(),
  purchaseId: uuidCol('purchase_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  quantity: decimal('quantity', { precision: 10, scale: 3 }).notNull(),
  purchasePrice: decimal('purchase_price', { precision: 12, scale: 2 }).notNull(),
  lineTotal: decimal('line_total', { precision: 12, scale: 2 }).notNull(),
});

export const purchaseOrders = mysqlTable('purchase_orders', {
  id: uuidCol('id').primaryKey(),
  orderNo: varchar('order_no', { length: 60 }).notNull(),
  supplierId: uuidCol('supplier_id'),
  branchId: uuidCol('branch_id'),
  total: decimal('total', { precision: 12, scale: 2 }).default('0.00'),
  status: varchar('status', { length: 30 }).default('pending').notNull(),
  expectedDate: date('expected_date'),
  notes: text('notes'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const purchaseOrderItems = mysqlTable('purchase_order_items', {
  id: uuidCol('id').primaryKey(),
  purchaseOrderId: uuidCol('purchase_order_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  quantity: decimal('quantity', { precision: 10, scale: 3 }).notNull(),
  estimatedPrice: decimal('estimated_price', { precision: 12, scale: 2 }),
  lineTotal: decimal('line_total', { precision: 12, scale: 2 }),
});

export const purchaseReturns = mysqlTable('purchase_returns', {
  id: uuidCol('id').primaryKey(),
  returnNo: varchar('return_no', { length: 60 }).notNull(),
  purchaseId: uuidCol('purchase_id'),
  supplierId: uuidCol('supplier_id'),
  branchId: uuidCol('branch_id'),
  totalRefund: decimal('total_refund', { precision: 12, scale: 2 }).default('0.00'),
  reason: text('reason'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const purchaseReturnItems = mysqlTable('purchase_return_items', {
  id: uuidCol('id').primaryKey(),
  purchaseReturnId: uuidCol('purchase_return_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  quantity: decimal('quantity', { precision: 10, scale: 3 }).notNull(),
  unitPrice: decimal('unit_price', { precision: 12, scale: 2 }).notNull(),
  lineTotal: decimal('line_total', { precision: 12, scale: 2 }).notNull(),
});

// ==========================================
// 6. CONTACTS & CRM
// ==========================================
export const contacts = mysqlTable('contacts', {
  id: uuidCol('id').primaryKey(),
  type: varchar('type', { length: 30 }).default('customer').notNull(), // 'customer' | 'supplier' | 'corporate' | 'rider'
  name: varchar('name', { length: 120 }).notNull(),
  phone: varchar('phone', { length: 30 }),
  email: varchar('email', { length: 120 }),
  address: text('address'),
  balance: decimal('balance', { precision: 12, scale: 2 }).default('0.00'), // positive = due
  loyaltyPoints: int('loyalty_points').default(0),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const customerAddresses = mysqlTable('customer_addresses', {
  id: uuidCol('id').primaryKey(),
  customerPhone: varchar('customer_phone', { length: 30 }).notNull(),
  tag: varchar('tag', { length: 60 }).default('Home'), // 'Home', 'Office'
  address: text('address').notNull(),
  area: varchar('area', { length: 100 }),
  isDefault: boolean('is_default').default(false).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const customerNotifications = mysqlTable('customer_notifications', {
  id: uuidCol('id').primaryKey(),
  customerPhone: varchar('customer_phone', { length: 30 }).notNull(),
  orderId: uuidCol('order_id'),
  body: text('body').notNull(),
  isSent: boolean('is_sent').default(false).notNull(),
  sendStatus: varchar('send_status', { length: 30 }).default('pending'),
  sendAttempts: int('send_attempts').default(0),
  lastError: text('last_error'),
  sentAt: timestamp('sent_at'),
  lastAttemptAt: timestamp('last_attempt_at'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const loyaltyLedger = mysqlTable('loyalty_ledger', {
  id: uuidCol('id').primaryKey(),
  phone: varchar('phone', { length: 30 }).notNull(),
  saleId: uuidCol('sale_id'),
  orderId: uuidCol('order_id'),
  pointsEarned: int('points_earned').default(0),
  pointsRedeemed: int('points_redeemed').default(0),
  pointsBalance: int('points_balance').default(0),
  note: text('note'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

// ==========================================
// 7. DELIVERY & ONLINE ORDERS
// ==========================================
export const deliveryOrders = mysqlTable('delivery_orders', {
  id: uuidCol('id').primaryKey(),
  orderNo: bigint('order_no', { mode: 'number' }),
  customerName: varchar('customer_name', { length: 120 }).notNull(),
  customerPhone: varchar('customer_phone', { length: 30 }).notNull(),
  deliveryAddress: text('delivery_address').notNull(),
  zoneId: uuidCol('zone_id'),
  deliverySlot: varchar('delivery_slot', { length: 60 }),
  deliveryDate: date('delivery_date'),
  subtotal: decimal('subtotal', { precision: 12, scale: 2 }).default('0.00').notNull(),
  deliveryFee: decimal('delivery_fee', { precision: 12, scale: 2 }).default('0.00').notNull(),
  discount: decimal('discount', { precision: 12, scale: 2 }).default('0.00'),
  total: decimal('total', { precision: 12, scale: 2 }).default('0.00').notNull(),
  paymentMethod: varchar('payment_method', { length: 50 }).default('cod').notNull(),
  paymentStatus: varchar('payment_status', { length: 30 }).default('unpaid').notNull(),
  status: varchar('status', { length: 30 }).default('pending').notNull(), // 'pending','confirmed','packing','out_for_delivery','delivered','cancelled'
  riderId: uuidCol('rider_id'),
  notes: text('notes'),
  cancellationReason: text('cancellation_reason'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const deliveryOrderItems = mysqlTable('delivery_order_items', {
  id: uuidCol('id').primaryKey(),
  deliveryOrderId: uuidCol('delivery_order_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  productName: varchar('product_name', { length: 255 }).notNull(),
  quantity: decimal('quantity', { precision: 10, scale: 3 }).notNull(),
  unitPrice: decimal('unit_price', { precision: 12, scale: 2 }).notNull(),
  lineTotal: decimal('line_total', { precision: 12, scale: 2 }).notNull(),
});

export const deliveryOrderEvents = mysqlTable('delivery_order_events', {
  id: uuidCol('id').primaryKey(),
  orderId: uuidCol('order_id').notNull(),
  status: varchar('status', { length: 30 }).notNull(),
  notes: text('notes'),
  actor: varchar('actor', { length: 100 }),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const deliveryZones = mysqlTable('delivery_zones', {
  id: uuidCol('id').primaryKey(),
  nameEn: varchar('name_en', { length: 120 }).notNull(),
  nameBn: varchar('name_bn', { length: 120 }).notNull(),
  deliveryFee: decimal('delivery_fee', { precision: 12, scale: 2 }).default('0.00').notNull(),
  minOrder: decimal('min_order', { precision: 12, scale: 2 }).default('0.00').notNull(),
  freeDeliveryAbove: decimal('free_delivery_above', { precision: 12, scale: 2 }),
  etaMinutes: int('eta_minutes').default(60),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const deliverySlotCapacity = mysqlTable('delivery_slot_capacity', {
  id: uuidCol('id').primaryKey(),
  slotDate: date('slot_date').notNull(),
  slotKey: varchar('slot_key', { length: 50 }).notNull(), // 'morning' | 'afternoon' | 'evening'
  capacity: int('capacity').default(50).notNull(),
  booked: int('booked').default(0).notNull(),
});

export const deliveryRiders = mysqlTable('delivery_riders', {
  id: uuidCol('id').primaryKey(),
  name: varchar('name', { length: 120 }).notNull(),
  phone: varchar('phone', { length: 30 }).notNull(),
  vehicle: varchar('vehicle', { length: 60 }),
  branchId: uuidCol('branch_id'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const deliveryProofs = mysqlTable('delivery_proofs', {
  id: uuidCol('id').primaryKey(),
  orderId: uuidCol('order_id').notNull(),
  orderNo: int('order_no'),
  filePath: text('file_path').notNull(),
  status: varchar('status', { length: 30 }).default('submitted'),
  verifiedBy: uuidCol('verified_by'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const deliveryFeedback = mysqlTable('delivery_feedback', {
  id: uuidCol('id').primaryKey(),
  orderId: uuidCol('order_id').notNull(),
  rating: int('rating').default(5).notNull(),
  comment: text('comment'),
  slaMinutes: int('sla_minutes'),
  isOverdue: boolean('is_overdue').default(false),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

// ==========================================
// 8. MARKETING: COUPONS & PROMOTIONS
// ==========================================
export const coupons = mysqlTable('coupons', {
  id: uuidCol('id').primaryKey(),
  code: varchar('code', { length: 60 }).unique().notNull(),
  type: varchar('type', { length: 20 }).default('fixed').notNull(), // 'fixed' | 'percent'
  value: decimal('value', { precision: 12, scale: 2 }).notNull(),
  minAmount: decimal('min_amount', { precision: 12, scale: 2 }).default('0.00'),
  maxDiscount: decimal('max_discount', { precision: 12, scale: 2 }),
  usageLimit: int('usage_limit'),
  usageCount: int('usage_count').default(0),
  expiresOn: date('expires_on'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const promotions = mysqlTable('promotions', {
  id: uuidCol('id').primaryKey(),
  title: varchar('title', { length: 150 }).notNull(),
  description: text('description'),
  bannerUrl: text('banner_url'),
  targetUrl: text('target_url'),
  badge: varchar('badge', { length: 60 }),
  startDate: date('start_date'),
  endDate: date('end_date'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

// ==========================================
// 9. INVENTORY AUDIT & MOVEMENTS
// ==========================================
export const stockAdjustments = mysqlTable('stock_adjustments', {
  id: uuidCol('id').primaryKey(),
  adjustmentNo: varchar('adjustment_no', { length: 60 }).notNull(),
  branchId: uuidCol('branch_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  type: varchar('type', { length: 30 }).notNull(), // 'increase' | 'decrease' | 'damage' | 'theft'
  quantity: int('quantity').notNull(),
  reason: text('reason'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const stockCounts = mysqlTable('stock_counts', {
  id: uuidCol('id').primaryKey(),
  countNo: varchar('count_no', { length: 60 }).notNull(),
  branchId: uuidCol('branch_id').notNull(),
  status: varchar('status', { length: 30 }).default('pending').notNull(),
  notes: text('notes'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const stockCountItems = mysqlTable('stock_count_items', {
  id: uuidCol('id').primaryKey(),
  stockCountId: uuidCol('stock_count_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  systemStock: int('system_stock').notNull(),
  countedStock: int('counted_stock').notNull(),
  difference: int('difference').notNull(),
});

export const stockTransfers = mysqlTable('stock_transfers', {
  id: uuidCol('id').primaryKey(),
  transferNo: varchar('transfer_no', { length: 60 }).notNull(),
  fromBranchId: uuidCol('from_branch_id').notNull(),
  toBranchId: uuidCol('to_branch_id').notNull(),
  status: varchar('status', { length: 30 }).default('pending').notNull(),
  notes: text('notes'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const stockTransferItems = mysqlTable('stock_transfer_items', {
  id: uuidCol('id').primaryKey(),
  stockTransferId: uuidCol('stock_transfer_id').notNull(),
  productId: uuidCol('product_id').notNull(),
  quantity: int('quantity').notNull(),
});

// ==========================================
// 10. ACCOUNTS & FINANCIALS
// ==========================================
export const accounts = mysqlTable('accounts', {
  id: uuidCol('id').primaryKey(),
  branchId: uuidCol('branch_id'),
  name: varchar('name', { length: 120 }).notNull(),
  type: varchar('type', { length: 50 }).notNull(), // 'cash' | 'bank' | 'mobile_money'
  accountNumber: varchar('account_number', { length: 60 }),
  bankName: varchar('bank_name', { length: 100 }),
  branch: varchar('branch', { length: 100 }),
  openingBalance: decimal('opening_balance', { precision: 12, scale: 2 }).default('0.00'),
  currentBalance: decimal('current_balance', { precision: 12, scale: 2 }).default('0.00'),
  note: text('note'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const accountTransactions = mysqlTable('account_transactions', {
  id: uuidCol('id').primaryKey(),
  branchId: uuidCol('branch_id'),
  accountId: uuidCol('account_id').notNull(),
  toAccountId: uuidCol('to_account_id'),
  type: varchar('type', { length: 30 }).notNull(), // 'deposit' | 'withdraw' | 'transfer'
  amount: decimal('amount', { precision: 12, scale: 2 }).notNull(),
  txnDate: date('txn_date').notNull(),
  note: text('note'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const ledgerAccounts = mysqlTable('ledger_accounts', {
  id: uuidCol('id').primaryKey(),
  code: varchar('code', { length: 30 }).unique().notNull(),
  name: varchar('name', { length: 120 }).notNull(),
  type: varchar('type', { length: 40 }).notNull(), // 'asset' | 'liability' | 'equity' | 'revenue' | 'expense'
  parentId: uuidCol('parent_id'),
  balance: decimal('balance', { precision: 12, scale: 2 }).default('0.00'),
  isActive: boolean('is_active').default(true).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const journalEntries = mysqlTable('journal_entries', {
  id: uuidCol('id').primaryKey(),
  entryNo: varchar('entry_no', { length: 60 }).notNull(),
  entryDate: date('entry_date').notNull(),
  reference: varchar('reference', { length: 100 }),
  description: text('description'),
  branchId: uuidCol('branch_id'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const journalLines = mysqlTable('journal_lines', {
  id: uuidCol('id').primaryKey(),
  journalEntryId: uuidCol('journal_entry_id').notNull(),
  ledgerAccountId: uuidCol('ledger_account_id').notNull(),
  debit: decimal('debit', { precision: 12, scale: 2 }).default('0.00').notNull(),
  credit: decimal('credit', { precision: 12, scale: 2 }).default('0.00').notNull(),
  memo: text('memo'),
});

export const expenseCategories = mysqlTable('expense_categories', {
  id: uuidCol('id').primaryKey(),
  name: varchar('name', { length: 100 }).notNull(),
  code: varchar('code', { length: 40 }),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});

export const expenses = mysqlTable('expenses', {
  id: uuidCol('id').primaryKey(),
  branchId: uuidCol('branch_id'),
  categoryId: uuidCol('category_id'),
  accountId: uuidCol('account_id'),
  amount: decimal('amount', { precision: 12, scale: 2 }).notNull(),
  spentOn: date('spent_on').notNull(),
  title: varchar('title', { length: 200 }),
  note: text('note'),
  receiptUrl: text('receipt_url'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().onUpdateNow(),
});

export const payments = mysqlTable('payments', {
  id: uuidCol('id').primaryKey(),
  branchId: uuidCol('branch_id'),
  contactId: uuidCol('contact_id'),
  saleId: uuidCol('sale_id'),
  purchaseId: uuidCol('purchase_id'),
  accountId: uuidCol('account_id'),
  type: varchar('type', { length: 30 }).notNull(), // 'receive' | 'pay'
  amount: decimal('amount', { precision: 12, scale: 2 }).notNull(),
  method: varchar('method', { length: 50 }).default('cash').notNull(),
  trxId: varchar('trx_id', { length: 100 }),
  paymentDate: date('payment_date').notNull(),
  note: text('note'),
  userId: uuidCol('user_id'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});
