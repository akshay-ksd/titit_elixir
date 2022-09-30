defmodule Connect.BuisnessDetails do
  use Ecto.Schema
  import Ecto.Changeset
  alias Connect.BuisnessDetails
  schema "buisness_details" do
    field :category_id, :integer
    field :description, :string
    field :is_desabled, :boolean, default: false
    field :latitude, :float
    field :location, :string
    field :longitude, :float
    field :shop_name, :string
    field :user_id, :integer
    field :website_address, :string

    timestamps()
  end
  def insert_buisness_data(category_id,description,latitude,location,longitude,shop_name,user_id,website_address) do                         
      %Connect.BuisnessDetails{
       category_id: category_id, 
       description: description,
       is_desabled: false,
       latitude: latitude,
       location: location,
       longitude: longitude,
       shop_name: shop_name,
       user_id: user_id,
       website_address: website_address
     }
    |> Connect.Repo.insert()
  end

  def update_buisness_description(description,user_id) do
    Connect.Repo.get_by(BuisnessDetails, user_id: user_id)
    |> Ecto.Changeset.change(%{description: description})
    |> Connect.Repo.update()
  end

  def update_buisness_location(latitude,longitude,location,user_id) do
    Connect.Repo.get_by(BuisnessDetails, user_id: user_id)
    |> Ecto.Changeset.change(%{latitude: latitude,
                               longitude: longitude,
                               location: location,
                               user_id: user_id})
    |> Connect.Repo.update()
  end

  def update_buisness_web_address(website_address,user_id) do
    Connect.Repo.get_by(BuisnessDetails, user_id: user_id)
    |> Ecto.Changeset.change(%{website_address: website_address})
    |> Connect.Repo.update()
  end

  def get_id_by_user_id(user_id) do
     case Connect.Repo.get_by(BuisnessDetails, user_id: user_id) do
      nil ->
       {:ok, "no id"}
      buisness_profile ->
       {:ok, buisness_profile}
     end
  end

  def update_buisness_data(category_id,description,latitude,location,longitude,shop_name,user_id,website_address) do                         

    Connect.Repo.get_by(BuisnessDetails, user_id: user_id)
    |> Ecto.Changeset.change(%{category_id: category_id, 
                               description: description,
                               is_desabled: false,
                               latitude: latitude,
                               location: location,
                               longitude: longitude,
                               shop_name: shop_name,
                               website_address: website_address})
    |> Connect.Repo.update()
  end

  def get_buisness_data(user_id) do
    Connect.Repo.get_by(BuisnessDetails, user_id: user_id)
  end
  
  def get_buisness_details_by_category() do
     Connect.Repo.all(BuisnessDetails)
  end

  @doc false
  def changeset(buisness_details, attrs) do
    buisness_details
    |> cast(attrs, [:category_id, :description, :latitude, :location, :longitude, :shop_name, :user_id, :website_address, :is_desabled])
    |> validate_required([:category_id, :description, :latitude, :location, :longitude, :shop_name, :user_id, :website_address, :is_desabled])
  end
end
