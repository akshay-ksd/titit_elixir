defmodule ConnectWeb.Schema.ProductTypes do
  use Absinthe.Schema.Notation

  alias ConnectWeb.Resolvers

  @desc "A product"
  object :product do
    field :id, :id
    field :category_name, :string
  end

  @desc "A product"
  object :category do
    field :id, :id
    field :category_name, :string
  end

  @desc "Update description"
  object :description_type do
    field :user_token, :string
    field :description, :string
  end

  @desc "Update location"
  object :location_type do
    field :latitude, :float
    field :longitude, :float
    field :location, :string
    field :user_token, :string
  end

  @desc "Update web_address"
  object :web_address_type do
    field :user_token, :string
    field :website_address, :string
  end

  @desc "A product"
  object :buisnees_data do
    field :shop_name, :string
  end

  object :get_products do
    field :products, list_of(:product) do
      resolve(&Resolvers.Products.list_category/2)
    end
  end

  @desc "insert product category"
  object :product_category_type do
    field :category, :string
    field :user_token, :string
    field :category_token, :string
  end

  @desc "delete product category"
  object :product_category_delete_type do
    field :user_token, :string
    field :category_token, :string
  end

  @desc "insert product"
  object :product_type do
    field :user_token, :string
    field :product_token, :string
    field :buttton_type, :string
    field :category_token, :string
    field :is_available, :boolean
    field :offer_price, :integer
    field :p_description, :string
    field :price, :integer
    field :product_name, :string
  end

  @desc "delete product"
  object :p_delete_type do
    field :user_token, :string
    field :product_token, :string
  end

  @desc "buisness_details"
  object :buisness_details do
    field :id, :integer
    field :category_id, :integer
    field :description, :string
    field :latitude, :float
    field :location, :string
    field :longitude, :float
    field :shop_name, :string
    field :website_address, :string
  end

  @desc "get_pcategory_details"
  object :pcategory_details do
    field :buisness_id, :string
    field :category_name, :string
    field :category_token, :string
    field :is_disabled, :string
  end

  @desc "get product"
  object :get_product_type do
    field :id, :integer
    field :buisness_id, :integer
    field :buttton_type, :string
    field :category_token, :string
    field :is_available, :boolean
    field :offer_price, :integer
    field :p_description, :string
    field :price, :integer
    field :product_name, :string
    field :product_token, :string
  end

  @desc "pcategory_details_by_bid"
  object :pcategory_details_by_bid do
    field :id, :integer
    field :buisness_id, :string
    field :category_name, :string
    field :category_token, :string
    field :is_disabled, :string
  end
end