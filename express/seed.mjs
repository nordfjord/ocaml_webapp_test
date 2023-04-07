import crypto from 'node:crypto'
import pg from 'pg'
const client = new pg.Client(
  'postgresql://message_store:@localhost:5432/message_store',
)



await client.connect()

const streamName = `ContactPreferences-${crypto.randomUUID()}`
for (let i = 0; i < 2000; ++i) {
  await client.query(
    `select * from write_message($1, $2, $3, $4)`,
    [crypto.randomUUID(), streamName, "TestEvent", JSON.stringify({ number: i })]
  )
}

client.end()

