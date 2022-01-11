defmodule AppWeb.LiveHelpers do
  @moduledoc false
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.list_index_path(@socket, :index)}>
        <.live_component
          module={AppWeb.ListLive.FormComponent}
          id={@list.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.list_index_path(@socket, :index)}
          list: @list
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="phx-modal fade-in" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="w-1/2 overflow-hidden shadow-lg phx-modal-content rounded-xl bg-slate-200"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <div class="flex items-center justify-end px-4 pt-4">
          <%= if @return_to do %>
            <%= live_patch "✖",
              to: @return_to,
              id: "close",
              class: "phx-modal-close px-2 py-1 transform bg-white rounded-full shadow-md hover:bg-amber-200 hover:scale-95 hover:shadow-none",
              phx_click: hide_modal()
            %>
          <% else %>
          <a id="close" href="#" class="px-2 py-1 transform bg-white rounded-full shadow-md phx-modal-close hover:bg-amber-200 hover:scale-95 hover:shadow-none" phx-click={hide_modal()}>✖</a>
          <% end %>
        </div>

        <div class="p-4">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
