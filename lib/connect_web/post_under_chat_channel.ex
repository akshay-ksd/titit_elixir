defmodule ConnectWeb.PostUnderChatChannel do
   use ConnectWeb, :channel
   alias Connect.PostMessage
   alias Connect.UserProfile
   alias ConnectWeb.PostUnderChatPresence
   require Logger

   intercept ["new_message"]
   intercept ["join_request"]

   def join("post_under_chat:" <> _geohash, %{"position" => position}, socket) do
    send(self(), {:after_join, position})
    {:ok, %{}, socket}
   end

   def handle_in("new_message", %{"messages" => messages}, socket) do
      with {:ok, request} <- PostMessage.upload_to_database(socket.assigns[:current_user], messages),
           {:ok, user} = UserProfile.get_id_by_token(request.user_token) do 
           user_token = String.replace(request.user_token, ~s("), "")
      broadcast!(socket, "new_message", %{user_name: user.user_name, 
                                       profile_image_url: user.image_url, 
                                       chat: messages["chat"], 
                                       contact_name: messages["contact_name"], 
                                       contact_number: messages["contact_number"], 
                                       image_url: messages["image_url"], 
                                       thumbnail_url: messages["thumbnail_url"], 
                                       type: messages["type"],
                                       video_url: messages["video_url"], 
                                       time: request.inserted_at,
                                       id: "#{"aksd"}#{request.id}", 
                                       uid: user_token,
                                       recieved: request.recieved,
                                       local_id: request.local_id,
                                       latitude: messages["latitude"],
                                       longitude: messages["longitude"]
                                       })
       else 
            {:error, reason} ->
      end
       {:noreply, socket}
  end
  
  def handle_info({:after_join, position}, socket) do
  {:ok, user} = UserProfile.get_token_by_user_id(socket.assigns.user_id)
   {:ok, _} = PostUnderChatPresence.track(socket, socket.assigns.user_id, %{
      online_at: inspect(System.system_time(:second)), 
      user_id: socket.assigns.user_id, 
      user_toke: user.token,
      is_joinrequest: false,
      user_name: user.user_name, 
      profile_image_url: user.image_url,
      latitude: position["latitude"], 
      longitude: position["longitude"]
    })

    push(socket, "presence_state", PostUnderChatPresence.list(socket))
    {:noreply, socket}
  end

   def handle_out("new_message", payload, socket) do
     push(socket, "new_message", payload)
     {:noreply, socket}
  end

   def handle_in("join_request", %{"messages" => messages}, socket) do
      with {:ok, request} <- PostMessage.upload_to_database(socket.assigns[:current_user], messages),
           {:ok, user} = UserProfile.get_id_by_token(request.user_token) do 
           user_token = String.replace(request.user_token, ~s("), "")
      broadcast!(socket, "join_request", %{user_name: user.user_name, 
                                       profile_image_url: user.image_url, 
                                       chat: messages["chat"], 
                                       contact_name: messages["contact_name"], 
                                       contact_number: messages["contact_number"], 
                                       image_url: messages["image_url"], 
                                       thumbnail_url: messages["thumbnail_url"], 
                                       type: messages["type"],
                                       video_url: messages["video_url"], 
                                       time: request.inserted_at,
                                       id: "#{"aksd"}#{request.id}", 
                                       uid: user_token,
                                       recieved: request.recieved,
                                       local_id: request.local_id,
                                       latitude: messages["latitude"],
                                       longitude: messages["longitude"]
                                       })
       else 
            {:error, reason} ->
      end
       {:noreply, socket}
  end

    def handle_in("update_position", %{"messages" => messages}, socket) do
     {:ok, user} = UserProfile.get_token_by_user_id(socket.assigns.user_id)
     {:ok, _} = PostUnderChatPresence.update(socket, socket.assigns.user_id, %{
      online_at: inspect(System.system_time(:second)), 
      user_id: socket.assigns.user_id, 
      user_toke: user.token,
      is_joinrequest: false,
      user_name: user.user_name, 
      profile_image_url: user.image_url,
      latitude: messages["latitude"], 
      longitude: messages["longitude"]
    })
    {:noreply, socket}
  end
   def handle_out("join_request", payload, socket) do
     push(socket, "join_request", payload)
     {:noreply, socket}
  end
end