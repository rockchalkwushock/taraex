defmodule App.Repo.Migrations.CreateLists do
  use Ecto.Migration

  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  def change do
    create table(:lists) do
      add :color, :string
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(@timestamps_opts)
    end

    create index(:lists, [:user_id])
  end
end
