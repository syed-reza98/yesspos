import * as schema from './schema';

export const tableMap: Record<string, any> = {
  users: schema.users,
  user_roles: schema.userRoles,
  profiles: schema.profiles,
  business_settings: schema.businessSettings,
  branches: schema.branches,
  site_content: schema.siteContent,
  api_settings: schema.apiSettings,
  media_assets: schema.mediaAssets,
  audit_logs: schema.auditLogs,
  categories: schema.categories,
  brands: schema.brands,
  units: schema.units,
  products: schema.products,
  product_stock: schema.productStock,
  product_reviews: schema.productReviews,
  sales: schema.sales,
  sale_items: schema.saleItems,
  sale_returns: schema.saleReturns,
  sale_return_items: schema.saleReturnItems,
  user_carts: schema.userCarts,
  purchases: schema.purchases,
  purchase_items: schema.purchaseItems,
  purchase_orders: schema.purchaseOrders,
  purchase_order_items: schema.purchaseOrderItems,
  purchase_returns: schema.purchaseReturns,
  purchase_return_items: schema.purchaseReturnItems,
  contacts: schema.contacts,
  customer_addresses: schema.customerAddresses,
  customer_notifications: schema.customerNotifications,
  loyalty_ledger: schema.loyaltyLedger,
  delivery_orders: schema.deliveryOrders,
  delivery_order_items: schema.deliveryOrderItems,
  delivery_order_events: schema.deliveryOrderEvents,
  delivery_zones: schema.deliveryZones,
  delivery_slot_capacity: schema.deliverySlotCapacity,
  delivery_riders: schema.deliveryRiders,
  delivery_proofs: schema.deliveryProofs,
  delivery_feedback: schema.deliveryFeedback,
  coupons: schema.coupons,
  promotions: schema.promotions,
  stock_adjustments: schema.stockAdjustments,
  stock_counts: schema.stockCounts,
  stock_count_items: schema.stockCountItems,
  stock_transfers: schema.stockTransfers,
  stock_transfer_items: schema.stockTransferItems,
  accounts: schema.accounts,
  account_transactions: schema.accountTransactions,
  ledger_accounts: schema.ledgerAccounts,
  journal_entries: schema.journalEntries,
  journal_lines: schema.journalLines,
  expense_categories: schema.expenseCategories,
  expenses: schema.expenses,
  payments: schema.payments,
};

// Map snake_case property keys to camelCase Drizzle columns
export function mapSnakeToCamel(row: Record<string, any>): Record<string, any> {
  if (!row || typeof row !== 'object') return row;
  const out: Record<string, any> = {};
  for (const [k, v] of Object.entries(row)) {
    const camel = k.replace(/_([a-z0-9])/g, (_, letter) => letter.toUpperCase());
    out[camel] = v;
  }
  return out;
}

// Map camelCase Drizzle columns to snake_case for Supabase compatibility
export function mapCamelToSnake(row: Record<string, any>): Record<string, any> {
  if (!row || typeof row !== 'object') return row;
  const out: Record<string, any> = {};
  for (const [k, v] of Object.entries(row)) {
    const snake = k.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);
    out[snake] = v;
  }
  return out;
}
