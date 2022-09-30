defmodule Connect.PostData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_data" do
    field :emergency, :boolean, default: false
    field :image_url, :string
    field :latitude, :float
    field :local_id, :string
    field :longitude, :float
    field :post, :string
    field :responce, :integer
    field :sharing_location_latitude, :float
    field :sharing_location_longitude, :float
    field :user_token, :string
    field :video_thumbnail, :string
    field :video_url, :string

    timestamps()
  end
  
   def upload_to_database(user, %{"emergency" => emergency, 
                                 "image_url" => image_url, 
                                 "latitude" => latitude, 
                                 "longitude" => longitude, 
                                 "post" => post, 
                                 "responce" => responce, 
                                 "sharing_location_latitude" => sharing_location_latitude,
                                 "sharing_location_longitude" => sharing_location_longitude, 
                                 "video_url" => video_url,
                                 "token" => token, 
                                 "video_thumbnail" => video_thumbnail, 
                                 "local_id" => local_id}) do
    %Connect.PostData{
       emergency: emergency,
       image_url: image_url,
       latitude: latitude,
       longitude: longitude,
       post: post,
       responce: responce,
       sharing_location_latitude: sharing_location_latitude,
       sharing_location_longitude: sharing_location_longitude,
       video_url: video_url,
       user_token: token, 
       video_thumbnail: video_thumbnail,
       local_id: local_id,
    }

    |> Connect.Repo.insert()
  end

  @doc false
  def changeset(post_data, attrs) do
    post_data
    |> cast(attrs, [:emergency, :image_url, :latitude, :longitude, :user_token, :video_thumbnail, :video_url, :local_id, :post, :responce, :sharing_location_latitude, :sharing_location_longitude])
    |> validate_required([:emergency, :image_url, :latitude, :longitude, :user_token, :video_thumbnail, :video_url, :local_id, :post, :responce, :sharing_location_latitude, :sharing_location_longitude])
  end
end
