import postgres from 'postgres';

const json = (body, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: {
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'no-store'
    }
  });

export default async function handler(request) {
  if (request.method !== 'GET') {
    return json({ error: 'Method not allowed' }, 405);
  }

  const connection = Netlify.env.get('DATABASE_URL');
  if (!connection) {
    return json({ error: 'Database is not configured' }, 503);
  }

  const sql = postgres(connection, {
    max: 1,
    connect_timeout: 8,
    idle_timeout: 2
  });

  try {
    const works = await sql`
      SELECT id, title, fiscal_year, amount, status, department
      FROM public.ward_works
      ORDER BY id DESC
      LIMIT 1000
    `;

    return json({ works });
  } catch (error) {
    console.error('Database query failed:', error.code || error.name);
    return json({ error: 'Database temporarily unavailable' }, 503);
  } finally {
    await sql.end({ timeout: 2 });
  }
}

export const config = { path: '/api/works' };
