defmodule App.Content.Todo do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Accounts.User
  alias App.Content.List

  @optional_fields [:priority, :status]
  @required_fields [:description, :list_id, :title, :user_id]
  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  schema "todos" do
    field :description, :string
    field :priority, Ecto.Enum, values: [:low, :medium, :high], default: :low
    field :status, Ecto.Enum, values: [:completed, :in_progress, :unstarted], default: :unstarted
    field :title, :string

    belongs_to :list, List
    belongs_to :user, User

    timestamps(@timestamps_opts)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:list)
    |> assoc_constraint(:user)
  end
end
