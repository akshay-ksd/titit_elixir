defmodule ConnectWeb.CellChannel do
  use ConnectWeb, :channel
  alias Connect.PostData
  alias Connect.UserProfile
  alias Connect.Buisness_category
  alias Connect.Guardian
  require Logger
  intercept ["new_post"]

  def join("cell:" <> _geohash, _params, socket) do
    {:ok, %{id: _geohash}, socket}
  end

  def handle_in("new_post", %{"post" => post}, socket) do
      # {:ok, data} = Buisness_category.create_category(socket.assigns[:current_user], post)
      with {:ok, request} <- PostData.upload_to_database(socket.assigns[:current_user], post),
           {:ok, user} = UserProfile.get_id_by_token(request.user_token) do
          #  case Guardian.resource_from_token(request.user_token) do
          #     {:ok, token, _claims} ->
          #      Logger.info token
          #      _ ->
          #      :error
          #  end 
           user_token = String.replace(request.user_token, ~s("), "")
      broadcast!(socket, "new_post", %{user_name: user.user_name, 
                                       profile_image_url: user.image_url, 
                                       emergency: post["emergency"], 
                                       post_image_url: post["image_url"], 
                                       latitude: post["latitude"], 
                                       longitude: post["longitude"], 
                                       post: post["post"], 
                                       responce: post["responce"],
                                       sharing_location_latitude: post["sharing_location_latitude"], 
                                       sharing_location_longitude: post["sharing_location_longitude"], 
                                       video_url: post["video_url"], 
                                       time: request.inserted_at,
                                       id: "#{user_token}#{post["local_id"]}", 
                                       uid: user_token,
                                       post_id: request.id, 
                                       video_thumbnail: post["video_thumbnail"],
                                       local_id: post["local_id"],
                                       is_private: post["is_private"],
                                       place: post["place"], 
                                       post_type: post["post_type"],
                                       typ_category: post["typ_category"]
                                      })
       else 
            {:error, reason} ->
      end
            {:noreply, socket}
  end

  def handle_out("new_post", payload, socket) do
     push(socket, "new_post", payload)
     {:noreply, socket}
  end
end