defmodule ConnectWeb.UserSocket do
  use Phoenix.Socket
  alias Connect.Guardian
  alias Connect.UserProfile
  require Logger
  
  channel "cell:*", ConnectWeb.CellChannel
  channel "post_under_chat:*", ConnectWeb.PostUnderChatChannel
  channel "auto_ride:*", ConnectWeb.AutoRideChannel
  channel "user_message:*", ConnectWeb.UserChannel
  channel "message_room:*", ConnectWeb.MessageChannel
  ## Channels
  # channel "room:*", ConnectWeb.RoomChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  # @impl true
  # def connect(_params, socket, _connect_info) do
  #   {:ok, socket}
  # end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     ConnectWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  # @impl true
  # def id(_socket), do: nil

  def connect(%{"token" => token}, socket) do
    {:ok, user} = UserProfile.get_id_by_token(token) 
    {:ok, assign(socket, :user_id, user.id)}
  end

  # def connect(_params, _socket), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
