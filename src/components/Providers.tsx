'use client';

import { Suspense, useState } from 'react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { SessionProvider } from 'next-auth/react';
import { I18nProvider } from '@/lib/i18n';
import { Toaster } from '@/components/ui/sonner';
import { CareChat } from '@/components/CareChat';
import { CartAccountSync } from '@/lib/cart-sync';
import { usePathname } from 'next/navigation';

const DASHBOARD_PATHS = [
  'accounts',
  'api-hub',
  'assistant',
  'audit-logs',
  'branches',
  'catalog',
  'chart-of-accounts',
  'commerce',
  'contacts',
  'coupons',
  'dashboard',
  'data-backup',
  'day-book',
  'delivery-orders',
  'delivery-zones',
  'expenses',
  'financials',
  'inventory',
  'journal',
  'labels',
  'media',
  'mobile-payments',
  'notifications',
  'party-statement',
  'payments',
  'pos',
  'product-audit',
  'products',
  'promotions',
  'purchase-orders',
  'purchases',
  'reports',
  'reviews',
  'riders',
  'sales',
  'settings',
  'site-content',
  'stock-adjustments',
  'stock-count',
  'stock-transfers',
  'users',
].map((r) => `/${r}`);

function CareChatWrapper() {
  const pathname = usePathname() || '/';
  const isDashboard = DASHBOARD_PATHS.some((p) => pathname.startsWith(p));
  const isAuth = pathname.startsWith('/auth');
  const showCare = !isDashboard && !isAuth;

  if (!showCare) return null;
  return <CareChat />;
}

export function Providers({ children }: { children: React.ReactNode }) {
  const [queryClient] = useState(
    () =>
      new QueryClient({
        defaultOptions: {
          queries: {
            staleTime: 1000 * 60 * 5,
            retry: 1,
          },
        },
      })
  );

  return (
    <SessionProvider refetchInterval={0} refetchOnWindowFocus={false}>
      <QueryClientProvider client={queryClient}>
        <I18nProvider>
          <Suspense fallback={null}>
            <CartAccountSync />
            {children}
            <CareChatWrapper />
            <Toaster position="top-center" />
          </Suspense>
        </I18nProvider>
      </QueryClientProvider>
    </SessionProvider>
  );
}
