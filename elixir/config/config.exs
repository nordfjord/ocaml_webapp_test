import Config
config :web, Web.Repo,
    url: "postgres://message_store:@localhost:5432/message_store",
    pool_size: 80,
    queue_target: 1000
    

config :logger, level: :info
