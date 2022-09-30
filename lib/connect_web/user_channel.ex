defmodule ConnectWeb.UserChannel do
 use ConnectWeb, :channel
 intercept ["new_message"]

    def join("user_message:" <> _geohash, _params, socket) do
        {:ok, %{}, socket}
    end

    def handle_in("new_message", %{"message" => message}, socket) do
        {:noreply, socket}
    end

    def handle_out("new_message", payload, socket) do
        push(socket, "new_message", payload)
        {:noreply, socket}
    end
end