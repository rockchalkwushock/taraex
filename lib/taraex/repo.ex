defmodule App.Repo do
  use Ecto.Repo,
    otp_app: :taraex,
    adapter: Ecto.Adapters.Postgres
end
