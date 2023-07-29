const express = require("express");
const pg = require("pg");
const { DateTime } = require("luxon");

const pool = new pg.Pool({
  connectionString: "postgresql://message_store:@localhost:5432/message_store",
  max: 10,
});

const app = express();

app.get("/category/:category_name/:position", async (req, res, next) => {
  const client = await pool.connect();
  try {
    const category_name = req.params.category_name;
    const position = BigInt(req.params.position);

    const results = await client.query(
      `SELECT stream_name, position, time, data, metadata AS meta, type AS message_type 
        FROM get_category_messages($1, $2, 10)`,
      [category_name, position.toString()]
    );

    res.status(200).json(
      results.rows.map((row) => ({
        ...row,
        data: JSON.parse(row.data || 'null'),
        meta: JSON.parse(row.meta || 'null'),
        time: DateTime.fromSQL(row.time).toISO(),
      }))
    );
  } catch (err) {
    next(err);
  } finally {
    client.release();
  }
});

app.listen(3000, () => console.log("Listening on port 3000"));
