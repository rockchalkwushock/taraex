defmodule AppWeb.TodoLive.Index do
  use AppWeb, :live_view

  alias App.Content
  alias App.Content.Todo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :todos, list_todos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Todo")
    |> assign(:todo, Content.get_todo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Todo")
    |> assign(:todo, %Todo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Todos")
    |> assign(:todo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo = Content.get_todo!(id)
    {:ok, _} = Content.delete_todo(todo)

    {:noreply, assign(socket, :todos, list_todos())}
  end

  defp list_todos do
    Content.list_todos()
  end
end
