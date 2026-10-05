'use client';

import { Suspense } from 'react';
import { Route } from '@/routes/_authenticated/commerce';

const Component = (Route as any).component;

export default function Page() {
  return (
    <Suspense fallback={<div className="min-h-[50vh] flex items-center justify-center text-muted-foreground">Loading...</div>}>
      <Component />
    </Suspense>
  );
}
