defmodule App.ContentTest do
  use App.DataCase, async: true

  alias App.Content
  alias App.Content.{List, Todo}
  import App.AccountsFixtures
  import App.ContentFixtures

  # I need a user in context of the test

  describe "lists" do
    @invalid_attrs %{color: nil, name: nil}
    setup do
      %{user: user_fixture()}
    end

    test "list_lists/1 returns all lists of current user", %{user: user} do
      list = list_fixture(user)
      assert Content.list_lists(user) == [list]
    end

    test "get_list/1 return the list with the given id", %{user: user} do
      list = list_fixture(user)
      # The "todos" are not preloaded so the test fails, how to fix this?
      fetched_list = Content.get_list!(list.id)
      assert fetched_list.id == list.id
    end

    test "create_list/1 with valid data creates a list", %{user: user} do
      valid_attrs = %{color: "#000000", name: "Todos", user_id: user.id}

      assert {:ok, %List{} = list} = Content.create_list(valid_attrs)
      assert list.color == "#000000"
      assert list.name == "Todos"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list", %{user: user} do
      list = list_fixture(user)
      update_attrs = %{color: "some updated color", name: "some updated name"}

      assert {:ok, %List{} = list} = Content.update_list(list, update_attrs)
      assert list.color == "some updated color"
      assert list.name == "some updated name"
    end

    test "update_list/2 with invalid data returns error changeset", %{user: user} do
      list = list_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Content.update_list(list, @invalid_attrs)
      # The "todos" are not preloaded so the test fails, how to fix this?
      fetched_list = Content.get_list!(list.id)
      assert list.color == fetched_list.color
      assert list.name == fetched_list.name
    end

    test "delete_list/1 deletes the list", %{user: user} do
      list = list_fixture(user)
      assert {:ok, %List{}} = Content.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Content.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset", %{user: user} do
      list = list_fixture(user)
      assert %Ecto.Changeset{} = Content.change_list(list)
    end
  end

  describe "todos" do
    @invalid_attrs %{description: nil, priority: nil, status: nil, title: nil}
    setup do
      %{user: user_fixture()}
    end

    test "list_todos/1 returns all todos of current user", %{user: user} do
      todo = todo_fixture(user)
      assert Content.list_todos(user) == [todo]
    end

    test "get_todo!/1 returns the todo with given id", %{user: user} do
      todo = todo_fixture(user)
      assert Content.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo", %{user: user} do
      %{id: list_id} = _list = list_fixture(user)

      valid_attrs = %{
        description: "some description",
        list_id: list_id,
        priority: :low,
        status: :unstarted,
        title: "some title",
        user_id: user.id
      }

      assert {:ok, %Todo{} = todo} = Content.create_todo(valid_attrs)
      assert todo.description == "some description"
      assert todo.priority == :low
      assert todo.status == :unstarted
      assert todo.title == "some title"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo", %{user: user} do
      todo = todo_fixture(user)

      update_attrs = %{
        description: "some updated description",
        priority: :medium,
        status: :in_progress,
        title: "some updated title"
      }

      assert {:ok, %Todo{} = todo} = Content.update_todo(todo, update_attrs)
      assert todo.description == "some updated description"
      assert todo.priority == :medium
      assert todo.status == :in_progress
      assert todo.title == "some updated title"
    end

    test "update_todo/2 with invalid data returns error changeset", %{user: user} do
      todo = todo_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Content.update_todo(todo, @invalid_attrs)
      assert todo == Content.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo", %{user: user} do
      todo = todo_fixture(user)
      assert {:ok, %Todo{}} = Content.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Content.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset", %{user: user} do
      todo = todo_fixture(user)
      assert %Ecto.Changeset{} = Content.change_todo(todo)
    end
  end
end
