import NextAuth from 'next-auth';
import Credentials from 'next-auth/providers/credentials';
import bcrypt from 'bcryptjs';
import { db } from '@/db';
import { users } from '@/db/schema';
import { eq, or } from 'drizzle-orm';

export const { handlers, signIn, signOut, auth } = NextAuth({
  trustHost: true,
  session: { strategy: 'jwt' },
  pages: {
    signIn: '/auth',
    error: '/auth',
  },
  providers: [
    Credentials({
      id: 'staff-credentials',
      name: 'Staff Login',
      credentials: {
        username: { label: 'Username or Email', type: 'text' },
        password: { label: 'Password', type: 'password' },
      },
      async authorize(credentials) {
        if (!credentials?.username || !credentials?.password) return null;

        const identifier = String(credentials.username).trim().toLowerCase();
        const stripped = identifier.replace(/@sherapos\.local$/, '').replace(/@bazarbari\.local$/, '');
        const rawPassword = String(credentials.password);

        // Allow login by username or email
        const userList = await db
          .select()
          .from(users)
          .where(
            or(
              eq(users.username, identifier),
              eq(users.username, stripped),
              eq(users.email, identifier),
              eq(users.email, stripped)
            )
          )
          .limit(1);

        const user = userList[0];
        if (!user || !user.passwordHash || !user.isActive) return null;

        const isValid = await bcrypt.compare(rawPassword, user.passwordHash);
        if (!isValid) return null;

        return {
          id: user.id,
          name: user.name || user.username,
          email: user.email,
          role: user.role,
          userType: user.userType,
          branchId: user.branchId,
          phone: user.phone,
        };
      },
    }),
    Credentials({
      id: 'customer-credentials',
      name: 'Customer Login',
      credentials: {
        phone: { label: 'Phone', type: 'text' },
        pin: { label: 'PIN', type: 'password' },
      },
      async authorize(credentials) {
        if (!credentials?.phone || !credentials?.pin) return null;

        const rawPhone = String(credentials.phone).replace(/\D/g, '');
        const phone = rawPhone.startsWith('880') ? `0${rawPhone.slice(3)}` : rawPhone;
        const pin = String(credentials.pin);

        const userList = await db
          .select()
          .from(users)
          .where(eq(users.phone, phone))
          .limit(1);

        const user = userList[0];
        if (!user || !user.passwordHash || !user.isActive) return null;

        const isValid = await bcrypt.compare(pin, user.passwordHash);
        if (!isValid) return null;

        return {
          id: user.id,
          name: user.name || phone,
          email: user.email,
          role: user.role || 'customer',
          userType: 'customer',
          branchId: user.branchId,
          phone: user.phone,
        };
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
        token.role = (user as any).role || 'staff';
        token.userType = (user as any).userType || 'staff';
        token.branchId = (user as any).branchId || null;
        token.phone = (user as any).phone || null;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.id as string;
        (session.user as any).role = token.role;
        (session.user as any).userType = token.userType;
        (session.user as any).branchId = token.branchId;
        (session.user as any).phone = token.phone;
      }
      return session;
    },
  },
  secret: process.env.AUTH_SECRET || process.env.NEXTAUTH_SECRET || 'yesspos-super-secret-key-32-chars-long-authjs-2026',
});
