defmodule App.ContentTest do
  use App.DataCase

  alias App.Content

  describe "lists" do
    alias App.Content.List

    import App.AccountsFixtures
    import App.ContentFixtures

    @invalid_attrs %{color: nil, name: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Content.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Content.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      %{id: id} = _user = user_fixture()
      valid_attrs = %{color: "#000000", name: "Todos", user_id: id}

      assert {:ok, %List{} = list} = Content.create_list(valid_attrs)
      assert list.color == "#000000"
      assert list.name == "Todos"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      update_attrs = %{color: "some updated color", name: "some updated name"}

      assert {:ok, %List{} = list} = Content.update_list(list, update_attrs)
      assert list.color == "some updated color"
      assert list.name == "some updated name"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_list(list, @invalid_attrs)
      assert list == Content.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Content.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Content.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Content.change_list(list)
    end
  end

  describe "todos" do
    alias App.Content.Todo

    import App.AccountsFixtures
    import App.ContentFixtures

    @invalid_attrs %{description: nil, priority: nil, status: nil, title: nil}

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Content.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Content.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      %{id: list_id} = _list = list_fixture()
      %{id: user_id} = _user = user_fixture()
      valid_attrs = %{
        description: "some description",
        list_id: list_id,
        priority: :low,
        status: :unstarted,
        title: "some title",
        user_id: user_id
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

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      update_attrs = %{description: "some updated description", priority: :medium, status: :in_progress, title: "some updated title"}

      assert {:ok, %Todo{} = todo} = Content.update_todo(todo, update_attrs)
      assert todo.description == "some updated description"
      assert todo.priority == :medium
      assert todo.status == :in_progress
      assert todo.title == "some updated title"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_todo(todo, @invalid_attrs)
      assert todo == Content.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Content.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Content.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Content.change_todo(todo)
    end
  end
end
