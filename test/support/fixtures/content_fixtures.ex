defmodule App.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Content` context.
  """
  import App.AccountsFixtures

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    %{id: id} = _user = user_fixture()
    {:ok, list} =
      attrs
      |> Enum.into(%{
        color: "some color",
        name: "some name",
        user_id: id
      })
      |> App.Content.create_list()

    list
  end

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    %{id: list_id} = _list = list_fixture()
    %{id: user_id} = _user = user_fixture()
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        description: "some description",
        list_id: list_id,
        title: "some title",
        user_id: user_id
      })
      |> App.Content.create_todo()

    todo
  end
end
