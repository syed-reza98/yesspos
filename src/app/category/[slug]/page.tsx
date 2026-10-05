import { Suspense } from 'react';
import CategoryClient from './CategoryClient';

export default async function Page({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;

  return (
    <Suspense fallback={<div className="min-h-[50vh] flex items-center justify-center text-muted-foreground">Loading...</div>}>
      <CategoryClient slug={slug} />
    </Suspense>
  );
}
