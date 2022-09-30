defmodule Connect.PostMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_messages" do
    field :chat, :string
    field :contact_name, :string
    field :contact_number, :string
    field :image_url, :string
    field :latitude, :string
    field :local_id, :string
    field :longitude, :string
    field :recieved, :boolean, default: false
    field :thumbnail_url, :string
    field :type, :string
    field :user_token, :string
    field :video_url, :string

    timestamps()
  end
  
  def upload_to_database(user, %{"chat" => chat, 
                                 "contact_name" => contact_name, 
                                 "contact_number" => contact_number, 
                                 "image_url" => image_url, 
                                 "thumbnail_url" => thumbnail_url, 
                                 "type" => type, 
                                 "user_token" => user_token,
                                 "video_url" => video_url, 
                                 "local_id" => local_id,
                                 "latitude" => latitude,
                                 "longitude" => longitude
                                 }) do
    %Connect.PostMessage{
       chat: chat,
       contact_name: contact_name,
       contact_number: contact_number,
       image_url: image_url,
       thumbnail_url: thumbnail_url,
       type: type,
       user_token: user_token,
       video_url: video_url,
       recieved: true,
       local_id: local_id,
       latitude: latitude,
       longitude: longitude
    }

    |> Connect.Repo.insert()
  end
  @doc false
  def changeset(post_message, attrs) do
    post_message
    |> cast(attrs, [:chat, :contact_name, :contact_number, :image_url, :thumbnail_url, :type, :user_token, :video_url, :recieved, :local_id, :latitude, :longitude])
    |> validate_required([:chat, :contact_name, :contact_number, :image_url, :thumbnail_url, :type, :user_token, :video_url, :recieved, :local_id, :latitude, :longitude])
  end
end
