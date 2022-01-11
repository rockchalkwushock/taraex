defmodule AppWeb.ListLive.Index do
  @moduledoc false
  use AppWeb, :live_view

  alias App.Accounts.User
  alias App.Content
  alias App.Content.List

  @impl true
  def mount(_params, _session, socket) do
    completed = list_todos(socket.assigns.current_user, %{status: :completed})
    in_progress = list_todos(socket.assigns.current_user, %{status: :in_progress})
    lists = list_lists(socket.assigns.current_user)
    unstarted = list_todos(socket.assigns.current_user, %{status: :unstarted})

    socket = socket
      |> assign(:completed, completed)
      |> assign(:in_progress, in_progress)
      |> assign(:lists, lists)
      |> assign(:unstarted, unstarted)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit List")
    |> assign(:list, Content.get_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New List")
    |> assign(:list, %List{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "My Lists")
    |> assign(:list, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    list = Content.get_list!(id)
    {:ok, _} = Content.delete_list(list)

    {:noreply, assign(socket, :lists, list_lists(socket.assigns.current_user))}
  end

  defp list_lists(%User{} = user) do
    Content.list_lists(user)
  end

  defp list_todos(%User{} = user, attrs) do
    Content.list_todos(user, attrs)
  end
end
