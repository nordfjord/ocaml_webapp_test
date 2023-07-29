const express = require("express");
const pg = require("pg");
const { DateTime } = require("luxon");

const pool = new pg.Pool({
  connectionString: "postgresql://message_store:@localhost:5432/message_store",
  max: 80,
});

const app = express();

app.get("/category/:category_name/:position", async (req, res, next) => {
  const client = await pool.connect();
  try {
    const category_name = req.params.category_name;
    const position = BigInt(req.params.position);

    const results = await client.query({
      name: "get_category_messages",
      rowMode: "array",
      text: `SELECT stream_name, position, time, data, metadata, type 
        FROM get_category_messages($1, $2, 10)`,
      values: [category_name, position.toString()],
    });

    res.status(200).json(
      results.rows.map((row) => ({
        stream_name: row[0],
        position: Number(row[1]),
        time: DateTime.fromSQL(row[2]).toISO(),
        data: JSON.parse(row[3] || "null"),
        meta: JSON.parse(row[4] || "null"),
        type: row[5],
      }))
    );
  } catch (err) {
    next(err);
  } finally {
    client.release();
  }
});

app.listen(3000, () => console.log("Listening on port 3000"));
