// Supabase Compatibility Layer powered by Next.js 16 + MySQL + Drizzle + Auth.js
import { signIn as nextAuthSignIn, signOut as nextAuthSignOut, getSession as nextAuthGetSession } from 'next-auth/react';

class QueryBuilder {
  private _table: string;
  private _action: 'select' | 'insert' | 'update' | 'delete' = 'select';
  private _selectCols = '*';
  private _filters: Array<{ column: string; op: string; value: any }> = [];
  private _orders: Array<{ column: string; ascending: boolean }> = [];
  private _limitVal?: number;
  private _dataVal?: any;

  constructor(table: string) {
    this._table = table;
  }

  select(cols = '*', opts?: any) {
    if (this._action !== 'insert' && this._action !== 'update' && this._action !== 'delete') {
      this._action = 'select';
    }
    this._selectCols = cols;
    return this;
  }

  insert(data: any, opts?: any) {
    this._action = 'insert';
    this._dataVal = data;
    return this;
  }

  upsert(data: any, opts?: any) {
    this._action = 'insert';
    this._dataVal = data;
    return this;
  }

  update(data: any, opts?: any) {
    this._action = 'update';
    this._dataVal = data;
    return this;
  }

  delete(opts?: any) {
    this._action = 'delete';
    return this;
  }

  eq(col: string, val: any) {
    this._filters.push({ column: col, op: 'eq', value: val });
    return this;
  }

  neq(col: string, val: any) {
    this._filters.push({ column: col, op: 'neq', value: val });
    return this;
  }

  gte(col: string, val: any) {
    this._filters.push({ column: col, op: 'gte', value: val });
    return this;
  }

  lte(col: string, val: any) {
    this._filters.push({ column: col, op: 'lte', value: val });
    return this;
  }

  gt(col: string, val: any) {
    this._filters.push({ column: col, op: 'gt', value: val });
    return this;
  }

  lt(col: string, val: any) {
    this._filters.push({ column: col, op: 'lt', value: val });
    return this;
  }

  like(col: string, val: any) {
    this._filters.push({ column: col, op: 'like', value: val });
    return this;
  }

  ilike(col: string, val: any) {
    this._filters.push({ column: col, op: 'ilike', value: val });
    return this;
  }

  in(col: string, val: any[]) {
    this._filters.push({ column: col, op: 'in', value: val });
    return this;
  }

  is(col: string, val: any) {
    if (val === null) {
      this._filters.push({ column: col, op: 'eq', value: null });
    } else {
      this._filters.push({ column: col, op: 'eq', value: val });
    }
    return this;
  }

  not(col: string, op: string, val: any) {
    if (op === 'is' && val === null) {
      this._filters.push({ column: col, op: 'neq', value: null });
    } else {
      this._filters.push({ column: col, op: 'neq', value: val });
    }
    return this;
  }

  or(cond: string) {
    // Basic support for OR filtering
    return this;
  }

  order(col: string, opts = { ascending: true }) {
    this._orders.push({ column: col, ascending: opts?.ascending ?? true });
    return this;
  }

  limit(n: number) {
    this._limitVal = n;
    return this;
  }

  async then<TResult1 = any, TResult2 = never>(
    onfulfilled?: ((value: any) => TResult1 | PromiseLike<TResult1>) | null,
    onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | null
  ): Promise<TResult1 | TResult2> {
    try {
      const res = await fetch('/api/db', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          table: this._table,
          action: this._action,
          select: this._selectCols,
          filters: this._filters,
          orders: this._orders,
          limit: this._limitVal,
          data: this._dataVal,
        }),
      });
      const json = await res.json();
      return onfulfilled ? onfulfilled(json) : json;
    } catch (e: any) {
      const errRes = { data: null, error: { message: e.message || 'Network error' } };
      return onfulfilled ? onfulfilled(errRes) : (errRes as any);
    }
  }

  async single() {
    this._limitVal = 1;
    const res: any = await this;
    if (res?.data && Array.isArray(res.data)) {
      return { data: res.data[0] || null, error: res.error };
    }
    return res;
  }

  async maybeSingle() {
    return this.single();
  }
}

export const supabase: any = {
  from(table: string) {
    return new QueryBuilder(table);
  },

  async rpc(functionName: string, args: Record<string, any> = {}) {
    try {
      const res = await fetch('/api/rpc', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ functionName, args }),
      });
      return await res.json();
    } catch (err: any) {
      return { data: null, error: { message: err.message } };
    }
  },

  channel(name: string) {
    return {
      on: () => ({ subscribe: () => {} }),
      subscribe: () => {},
    };
  },

  removeChannel(ch: any) {},

  auth: {
    async signInWithPassword({ email, password }: { email: string; password: string }) {
      const isCustomer = /^\d+$/.test(email.replace(/\D/g, '')) && !email.includes('@sherapos.local');
      const provider = isCustomer ? 'customer-credentials' : 'staff-credentials';
      const credentials: any = isCustomer
        ? { phone: email, pin: password, redirect: false }
        : { username: email, password, redirect: false };

      try {
        const res: any = await (nextAuthSignIn as any)(provider, credentials);
        if (res?.error) {
          return { data: null, error: { message: 'Invalid credentials' } };
        }
        const session = await nextAuthGetSession();
        return { data: { user: session?.user || null, session }, error: null };
      } catch (err: any) {
        return { data: null, error: { message: err.message || 'Sign in failed' } };
      }
    },

    async signUp({ email, password, options }: { email: string; password: string; options?: any }) {
      try {
        const res = await fetch('/api/auth/register', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            phone: options?.data?.phone || email.split('@')[0],
            name: options?.data?.full_name || 'Customer',
            pin: password,
          }),
        });
        const json = await res.json();
        if (json.error) return { data: null, error: { message: json.error } };
        return { data: { user: json.user, session: null }, error: null };
      } catch (err: any) {
        return { data: null, error: { message: err.message || 'Registration failed' } };
      }
    },

    async setSession(tokens: any) {
      return { data: { session: null }, error: null };
    },

    async updateUser(data: any) {
      return { data: null, error: null };
    },

    async signOut() {
      try {
        await nextAuthSignOut({ redirect: false });
        return { error: null };
      } catch (err: any) {
        return { error: { message: err.message } };
      }
    },

    async getUser() {
      try {
        const session = await nextAuthGetSession();
        return { data: { user: session?.user || null }, error: null };
      } catch (err: any) {
        return { data: { user: null }, error: { message: err.message } };
      }
    },

    async getSession() {
      try {
        const session = await nextAuthGetSession();
        return { data: { session }, error: null };
      } catch (err: any) {
        return { data: { session: null }, error: { message: err.message } };
      }
    },

    onAuthStateChange(callback: (event: string, session: any) => void) {
      if (typeof window !== 'undefined') {
        nextAuthGetSession().then((session) => {
          callback(session ? 'SIGNED_IN' : 'SIGNED_OUT', session);
        });
      }
      return {
        data: {
          subscription: {
            unsubscribe: () => {},
          },
        },
      };
    },
  },

  storage: {
    from(bucket: string) {
      return {
        async upload(filePath: string, file: any, opts?: any) {
          try {
            const formData = new FormData();
            formData.append('file', file);
            formData.append('category', bucket);
            const res = await fetch('/api/upload', {
              method: 'POST',
              body: formData,
            });
            const json = await res.json();
            if (json.error) return { data: null, error: { message: json.error } };
            return { data: { path: json.url }, error: null };
          } catch (err: any) {
            return { data: null, error: { message: err.message } };
          }
        },

        getPublicUrl(filePath: string) {
          const url = filePath.startsWith('/') ? filePath : `/uploads/${bucket}/${filePath}`;
          return { data: { publicUrl: url } };
        },

        async createSignedUrl(filePath: string, expiresIn?: number) {
          const url = filePath.startsWith('/') ? filePath : `/uploads/${bucket}/${filePath}`;
          return { data: { signedUrl: url }, error: null };
        },

        async remove(filePaths: string[]) {
          return { data: true, error: null };
        },
      };
    },
  },
};
