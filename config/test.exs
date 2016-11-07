use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pyconar_talks, PyconarTalks.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pyconar_talks, PyconarTalks.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "pyconar_talks_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox