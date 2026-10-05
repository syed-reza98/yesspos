export function createServerFn(opts?: any) {
  let validatorFn: any = null;
  let handlerFn: any = async () => {};

  const builder = {
    middleware: (m?: any) => builder,
    validator: (v: any) => {
      validatorFn = v;
      return builder;
    },
    inputValidator: (v: any) => {
      validatorFn = v;
      return builder;
    },
    handler: (h: any) => {
      handlerFn = h;
      const callable: any = async (payload: any) => {
        const inputData = payload?.data !== undefined ? payload.data : payload;
        const validated = validatorFn ? validatorFn(inputData) : inputData;
        return handlerFn({ data: validated, context: { userId: 'admin' } });
      };
      return callable;
    },
  };
  return builder;
}

export function useServerFn(fn: any) {
  return fn;
}

export function createMiddleware(opts?: any) {
  const mw = {
    server: (fn: any) => fn,
    client: (fn: any) => fn,
  };
  return mw;
}

export function createStart() {
  return {};
}

export function createCsrfMiddleware(opts?: any) {
  return () => {};
}
