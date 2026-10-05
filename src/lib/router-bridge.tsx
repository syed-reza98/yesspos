'use client';

import React from 'react';
import NextLink from 'next/link';
import { useRouter as useNextRouter, usePathname, useSearchParams, useParams as useNextParams } from 'next/navigation';

export function Link({ to, href, search, params, children, ...props }: any) {
  let target = href || to || '/';
  if (params && typeof params === 'object') {
    for (const [k, v] of Object.entries(params)) {
      target = target.replace(`$${k}`, String(v)).replace(`:${k}`, String(v));
    }
  }
  if (search && typeof search === 'object') {
    const sp = new URLSearchParams();
    for (const [k, v] of Object.entries(search)) {
      if (v !== undefined && v !== null) sp.set(k, String(v));
    }
    const qs = sp.toString();
    if (qs) target = `${target}${target.includes('?') ? '&' : '?'}${qs}`;
  }
  return (
    <NextLink href={target} {...props}>
      {children}
    </NextLink>
  );
}

export function useNavigate() {
  const router = useNextRouter();
  return React.useCallback(
    (opts: any) => {
      if (typeof opts === 'string') {
        router.push(opts);
        return;
      }
      let target = opts?.to || '/';
      if (opts?.params && typeof opts.params === 'object') {
        for (const [k, v] of Object.entries(opts.params)) {
          target = target.replace(`$${k}`, String(v)).replace(`:${k}`, String(v));
        }
      }
      if (opts?.search && typeof opts.search === 'object') {
        const sp = new URLSearchParams();
        for (const [k, v] of Object.entries(opts.search)) {
          if (v !== undefined && v !== null) sp.set(k, String(v));
        }
        const qs = sp.toString();
        if (qs) target = `${target}${target.includes('?') ? '&' : '?'}${qs}`;
      }
      if (opts?.replace) router.replace(target);
      else router.push(target);
    },
    [router]
  );
}

export function useRouterState(opts?: { select?: (s: any) => any }) {
  const pathname = usePathname() || '/';
  const searchParams = useSearchParams();
  const searchStr = searchParams ? searchParams.toString() : '';
  const state = {
    location: {
      pathname,
      searchStr: searchStr ? `?${searchStr}` : '',
      href: `${pathname}${searchStr ? `?${searchStr}` : ''}`,
    },
  };
  return opts?.select ? opts.select(state) : state;
}

export function useParams() {
  return useNextParams() || {};
}

export function useSearch() {
  const searchParams = useSearchParams();
  const result: Record<string, string> = {};
  if (searchParams) {
    searchParams.forEach((value, key) => {
      result[key] = value;
    });
  }
  return result;
}

export function createFileRoute(path: string) {
  return function (config: any) {
    return {
      ...config,
      useRouteContext: () => ({ queryClient: null }),
      useSearch: useSearch,
      useParams: useParams,
      useNavigate: useNavigate,
    };
  };
}

export function createRootRouteWithContext<T = any>() {
  return function (config: any) {
    return {
      ...config,
    };
  };
}

export function createRouter(opts: any) {
  return opts;
}

export function Outlet({ children }: { children?: React.ReactNode }) {
  return <>{children}</>;
}

export function redirect(opts: any) {
  return opts;
}

export function useRouter() {
  const router = useNextRouter();
  const pathname = usePathname() || '/';
  return {
    ...router,
    invalidate: () => router.refresh(),
    state: {
      location: {
        pathname,
      },
    },
  };
}

export function HeadContent() {
  return null;
}

export function Scripts() {
  return null;
}
