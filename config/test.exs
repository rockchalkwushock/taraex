import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :taraex, App.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "taraex_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :taraex, AppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/fvlLtQ9zIwW6XAWTp67OsJHiK9JSnRkBxL8M0FZLxlLp2jKRUI/lbP6Y0u1u61e",
  server: false

# In test we don't send emails.
config :taraex, App.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
