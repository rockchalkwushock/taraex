defmodule App.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Content` context.
  """
  alias App.Accounts.User

  @doc """
  Generate a list.
  """
  def list_fixture(%User{} = user, attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        color: "some color",
        name: "some name",
        user_id: user.id
      })
      |> App.Content.create_list()

    list
  end

  @doc """
  Generate a todo.
  """
  def todo_fixture(%User{} = user, attrs \\ %{}) do
    %{id: list_id} = _list = list_fixture(user)

    {:ok, todo} =
      attrs
      |> Enum.into(%{
        description: "some description",
        list_id: list_id,
        title: "some title",
        user_id: user.id
      })
      |> App.Content.create_todo()

    todo
  end
end
