// Production entry point for cPanel Node.js Application Manager / Phusion Passenger
process.env.NODE_ENV = 'production';
process.env.PORT = process.env.PORT || '3000';

await import('./.next/standalone/server.js');
