defmodule App.Content.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Accounts.User
  alias App.Content.Todo

  @required_fields [:color, :name, :user_id]
  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  schema "lists" do
    field :color, :string
    field :name, :string

    belongs_to :user, User
    has_many :todos, Todo

    timestamps(@timestamps_opts)
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
