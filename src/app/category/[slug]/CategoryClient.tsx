'use client';

import { Route } from '@/routes/category.$slug';
import { RouteParamsProvider } from '@/lib/router-bridge';

const Component = (Route as any).component;

export default function CategoryClient({ slug }: { slug: string }) {
  return (
    <RouteParamsProvider params={{ slug }}>
      <Component />
    </RouteParamsProvider>
  );
}
