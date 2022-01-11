defmodule AppWeb.Live.InitAssigns do
  @moduledoc false
  import Phoenix.LiveView

  alias App.Accounts

  def on_mount(:default, _params, %{"user_token" => token}, socket) when is_binary(token) do
    user = Accounts.get_user_by_session_token(token)
    {:cont, assign(socket, current_user: user)}
  end
end
