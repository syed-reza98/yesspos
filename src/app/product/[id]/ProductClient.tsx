'use client';

import { Route } from '@/routes/product.$id';
import { RouteParamsProvider } from '@/lib/router-bridge';

const Component = (Route as any).component;

export default function ProductClient({ id }: { id: string }) {
  return (
    <RouteParamsProvider params={{ id }}>
      <Component />
    </RouteParamsProvider>
  );
}
