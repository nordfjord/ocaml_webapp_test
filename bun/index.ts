import { SQL } from "bun";

const sql = new SQL(
  "postgresql://message_store:@127.0.0.1:5432/message_store",
  { max: 10 },
);

Bun.serve({
  routes: {
    "/category/:category/:position": async (req) => {
      const category = req.params.category;
      const position = BigInt(req.params.position);
      const messages =
        await sql`SELECT stream_name, position, time, data, type FROM get_category_messages(${category}, ${position}, 10)`;
      return new Response(
        JSON.stringify(
          messages.map((m: any) => ({
            stream_name: m.stream_name,
            position: m.position,
            time: new Date(m.time),
            data: JSON.parse(m.data),
            message_type: m.type,
          })),
        ),
        {
          headers: { "Content-Type": "application/json" },
        },
      );
    },
  },
  port: 3000,
});

