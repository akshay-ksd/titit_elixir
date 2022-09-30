defmodule Connect.Products do
  use Ecto.Schema
  import Ecto.{Query, Changeset}, warn: false
  alias Connect.Products

  schema "products" do
    field :buisness_id, :integer
    field :buttton_type, :string
    field :category_token, :string
    field :is_available, :boolean, default: false
    field :offer_price, :integer
    field :p_description, :string
    field :price, :integer
    field :product_name, :string
    field :product_token, :string

    timestamps()
  end
  
  def insert_product(b_id,
                     product_token,
                     buttton_type,
                     category_token,
                     is_available,
                     offer_price,
                     p_description,
                     price,
                     product_name) do
     %Connect.Products{
       buisness_id: b_id, 
       buttton_type: buttton_type,
       category_token: category_token,
       is_available: is_available,
       offer_price: offer_price,
       p_description: p_description,
       price: price,
       product_name: product_name,
       product_token: product_token
     }
    |> Connect.Repo.insert()        
  end

  def update_product(b_id,
                     product_token,
                     buttton_type,
                     category_token,
                     is_available,
                     offer_price,
                     p_description,
                     price,
                     product_name) do

     Connect.Repo.get_by(Products, buisness_id: b_id, product_token: product_token)
     |> Ecto.Changeset.change(%{buttton_type: buttton_type,
                                is_available: is_available,
                                offer_price: offer_price,
                                p_description: p_description,
                                price: price,
                                product_name: product_name,
                                product_token: product_token})
    |> Connect.Repo.update()       
  end

  def delete_product(b_id,product_token) do
   data = Connect.Repo.get_by(Products, buisness_id: b_id, product_token: product_token)
   Connect.Repo.delete(data)
  end

  def get_product_data(b_id) do
    from(u in Products, where: u.buisness_id == ^b_id)
    |> Connect.Repo.all()
  end

  def get_product_data_randomly() do
    # query = from Products,order_by: fragment("RANDOM()"),limit: 10
    from(u in Products, order_by: fragment("RANDOM()"),limit: 100)
    |> Connect.Repo.all()
  end
  

  def get_product_by_category_and_bid(buisness_id,category_token) do
   from(u in Products, where: u.category_token == ^category_token and u.buisness_id == ^buisness_id)
    |> Connect.Repo.all()
  end
  @doc false
  def changeset(products, attrs) do
    products
    |> cast(attrs, [:buisness_id, :category_token, :product_name, :p_description, :price, :offer_price, :buttton_type, :is_available, :product_token])
    |> validate_required([:buisness_id, :category_token, :product_name, :p_description, :price, :offer_price, :buttton_type, :is_available, :product_token])
  end
end
