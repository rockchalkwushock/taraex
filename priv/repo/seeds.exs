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
alias App.{Repo}
alias App.Accounts.{User, UserToken}
alias App.Content.{List, Todo}

Repo.delete_all(User)
Repo.delete_all(UserToken)

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

# Create some users.
for attrs <- users do
  %User{}
    |> User.registration_changeset(attrs)
    |> User.confirm_changeset()
    |> Repo.insert!()
end

users = Repo.all(User)

lists = [
  %{
    color: "#000000",
    name: "My Todo List"
  },
  %{
    color: "#343434",
    name: "Grocery List"
  },
  %{
    color: "#123555",
    name: "School List"
  }
]

todos = [
  %{
    description: "my todo",
    title: "One"
  },
  %{
    description: "my todo",
    title: "Two"
  },
  %{
    description: "my todo",
    status: "completed",
    title: "Three"
  },
  %{
    description: "my todo",
    priority: "medium",
    status: "completed",
    title: "Four"
  },
  %{
    description: "my todo",
    priority: "medium",
    status: "in_progress",
    title: "Five"
  },
  %{
    description: "my todo",
    priority: "medium",
    status: "in_progress",
    title: "Six"
  },
  %{
    description: "my todo",
    priority: "high",
    status: "in_progress",
    title: "Seven"
  },
  %{
    description: "my todo",
    priority: "high",
    status: "in_progress",
    title: "Eight"
  }
]

# For each user:
for user <- users do
 # Create some lists
  for attrs <- lists do
    attrs = Map.put(attrs, :user_id, user.id)
    list = %List{}
      |> List.changeset(attrs)
      |> Repo.insert!()

    # Create some todos.
    for attrs <- todos do
      attrs = Map.put(attrs, :list_id, list.id)
      attrs = Map.put(attrs, :user_id, user.id)

      %Todo{}
      |> Todo.changeset(attrs)
      |> Repo.insert!()
    end
  end
end
