import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

const DASHBOARD_ROUTES = [
  '/dashboard',
  '/pos',
  '/sales',
  '/products',
  '/catalog',
  '/inventory',
  '/purchases',
  '/purchase-orders',
  '/contacts',
  '/accounts',
  '/financials',
  '/expenses',
  '/delivery-orders',
  '/delivery-zones',
  '/riders',
  '/coupons',
  '/promotions',
  '/reviews',
  '/notifications',
  '/branches',
  '/users',
  '/settings',
  '/api-hub',
  '/audit-logs',
  '/data-backup',
  '/media',
  '/site-content',
  '/stock-adjustments',
  '/stock-count',
  '/stock-transfers',
  '/labels',
  '/journal',
  '/day-book',
  '/chart-of-accounts',
  '/party-statement',
  '/mobile-payments',
  '/product-audit',
  '/commerce',
  '/assistant',
];

export function proxy(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Check auth session cookie for dashboard paths
  const isDashboardPath = DASHBOARD_ROUTES.some((route) => pathname.startsWith(route));
  if (isDashboardPath) {
    const sessionToken =
      request.cookies.get('authjs.session-token')?.value ||
      request.cookies.get('__Secure-authjs.session-token')?.value ||
      request.cookies.get('next-auth.session-token')?.value ||
      request.cookies.get('__Secure-next-auth.session-token')?.value;

    if (!sessionToken) {
      const authUrl = new URL('/auth', request.url);
      authUrl.searchParams.set('callbackUrl', pathname);
      return NextResponse.redirect(authUrl);
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|manifest.webmanifest|sw.js|products|uploads).*)',
  ],
};
