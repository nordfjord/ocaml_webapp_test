use actix_web::{web, App, HttpResponse, HttpServer, Result};
use chrono::{DateTime, Utc};
use deadpool_postgres::{Config, ManagerConfig, Pool, PoolConfig, RecyclingMethod, Runtime};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use tokio_postgres::{NoTls, Row};

#[derive(Deserialize)]
struct PathInfo {
    category_name: String,
    position: i64,
}

#[derive(Deserialize, Serialize)]
struct Message {
    stream_name: String,
    position: i64,
    time: DateTime<Utc>,
    data: Value,
    meta: Value,
    message_type: String,
}

fn from_row(row: &Row) -> Message {
    Message {
        stream_name: row.get(0),
        position: row.get(1),
        time: DateTime::from_utc(row.get(2), Utc),
        data: row.try_get::<usize, serde_json::Value>(3).unwrap_or(Value::Null),
        meta: row.try_get::<usize, serde_json::Value>(4).unwrap_or(Value::Null),
        message_type: row.get(5)
    }
}

async fn get_category_messages(
    path: web::Path<PathInfo>,
    db_pool: web::Data<Pool>,
) -> Result<HttpResponse> {
    let client = db_pool.get().await.unwrap();

    let query = "SELECT stream_name, position, time, data, metadata AS meta, type AS message_type 
         FROM get_category_messages($1, $2)";

    let rows = client
        .query(query, &[&path.category_name, &path.position])
        .await
        .unwrap();

    let messages: Vec<Message> = rows
        .iter()
        .map(from_row)
        .collect();

    Ok(HttpResponse::Ok().json(messages))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let mut cfg = Config::new();
    cfg.dbname = Some("message_store".to_string());
    cfg.host = Some("localhost".to_string());
    cfg.port = Some(5432);
    cfg.user = Some("message_store".to_string());
    cfg.pool = Some(PoolConfig::new(80));
    cfg.manager = Some(ManagerConfig {
        recycling_method: RecyclingMethod::Fast,
    });

    let pool = cfg.create_pool(Some(Runtime::Tokio1), NoTls).unwrap();

    HttpServer::new(move || {
        App::new().app_data(web::Data::new(pool.clone())).route(
            "/category/{category_name}/{position}",
            web::get().to(get_category_messages),
        )
    })
    .bind("0.0.0.0:3000")?
    .run()
    .await
}
