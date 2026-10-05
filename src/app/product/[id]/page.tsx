import { Suspense } from 'react';
import ProductClient from './ProductClient';

export default async function Page({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  return (
    <Suspense fallback={<div className="min-h-[50vh] flex items-center justify-center text-muted-foreground">Loading...</div>}>
      <ProductClient id={id} />
    </Suspense>
  );
}
