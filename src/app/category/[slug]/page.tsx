import { Suspense } from 'react';
import CategoryClient from './CategoryClient';
import type { Metadata } from 'next';

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const name = slug === 'all' ? 'All products' : slug.replace(/-/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase());
  return {
    title: `${name} online in Dhaka — home delivery | Bazar Bari`,
    description: `Browse ${name.toLowerCase()} at Bazar Bari. Fresh stock, transparent prices and 1-hour home delivery in Dhaka.`,
  };
}

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
