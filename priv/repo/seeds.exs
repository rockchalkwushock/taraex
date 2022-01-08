# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias App.{Accounts, Repo}

Repo.delete_all(Accounts.User)
Repo.delete_all(Accounts.UserToken)

users = [
  %{
    email: "turd@gmail.com",
    password: "h3ll0_W0rld-123*"
  },
  %{
    email: "jim-nasium@gmail.com",
    password: "h3ll0_W0rld-123*"
  }
]

for user <- users do
  user
  |> Accounts.register_user()
end
