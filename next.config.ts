import type { NextConfig } from 'next';
import path from 'path';

const nextConfig: NextConfig = {
  output: 'standalone',
  serverExternalPackages: ['mysql2', 'bcryptjs'],
  cacheComponents: true,
  experimental: {
    instantInsights: {
      validationLevel: 'manual-warning',
    },
  },
  images: {
    unoptimized: true,
  },
  turbopack: {
    resolveAlias: {
      '@tanstack/react-router': './src/lib/router-bridge.tsx',
      '@tanstack/react-start': './src/lib/server-fn-bridge.ts',
    },
  },
  webpack: (config) => {
    config.resolve.alias = {
      ...config.resolve.alias,
      '@tanstack/react-router': path.resolve(process.cwd(), 'src/lib/router-bridge.tsx'),
      '@tanstack/react-start': path.resolve(process.cwd(), 'src/lib/server-fn-bridge.ts'),
    };
    return config;
  },
};

export default nextConfig;
