defmodule ConnectWeb.AutoRideChannel do
 use ConnectWeb, :channel

 def join("auto_ride:" <> _geohash, _params, socket) do
      {:ok, %{}, socket}
 end

 def handle_in("new_ride", %{"post" => post}, socket) do
        {:noreply, socket}
 end
end