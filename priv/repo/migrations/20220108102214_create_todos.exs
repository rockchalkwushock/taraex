defmodule App.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  def change do
    create table(:todos) do
      add :description, :text, null: false
      add :priority, :string, null: false, default: "low"
      add :status, :string, null: false, default: "unstarted"
      add :title, :string, null: false
      add :list_id, references(:lists, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(@timestamps_opts)
    end

    create index(:todos, [:list_id])
    create index(:todos, [:user_id])
  end
end
