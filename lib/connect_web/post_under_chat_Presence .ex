defmodule ConnectWeb.PostUnderChatPresence do
  use Phoenix.Presence,
    otp_app: :connect,
    pubsub_server: Connect.PubSub
end