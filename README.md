# Taraex

## Domain

```elixir
# User
defmodule App.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema :users do
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    field :confirmed_at, :naive_datetime

    has_many :lists, App.Accounts.List
    has_many :todos, through: [:lists, :todos]

    timestamps()
  end
end
# User Token
defmodule App.Accounts.UserToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema :users_tokens do
    field :token, :binary
    field :context, :string
    field :sent_to, :string

    belongs_to :user, App.Accounts.User

    timestamps(updated_at: false)
  end
end
# List
defmodule App.Content.List do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:color, :name]
  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  schema :lists do
    field :color, :string
    field :name, :string

    has_many :todos, App.Accounts.Todo
    belongs_to :user, App.Accounts.User

    timestamps(@timestamps_opts)
  end
end
# Todo
defmodule App.Content.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @priority_values [:low, :medium, :high]
  @required_fields [:description, :title]
  @status_values [:completed, :in_progress, :unstarted]
  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  schema :todos do
    field :description, :string
    field :priority, Ecto.Enum, values: @priority_values, default: :low
    field :status, Ecto.Enum, values: @status_values, default: :unstarted
    field :title, :string

    belongs_to :list, App.Contents.List
    belongs_to :user, App.Accounts.User

    timestamps(@timestamps_opts)
  end
end
```
