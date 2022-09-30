defmodule ConnectWeb.Schema do
  use Absinthe.Schema
  # alias ConnectWeb.Resolvers
  alias ConnectWeb.Schema

  # alias ConnectWeb.Resolvers

  import_types(Schema.ProductTypes)

  query do
    field :category_list, list_of(:category) do
      resolve(&Connect.Category.CategoryResolver.all/2)
    end

    field :get_buisness_details, list_of(:buisness_details) do
      arg(:user_token, non_null(:string))
      resolve(&Connect.Buisness.BuisnessResolver.get_buisness_data/2)
    end

    field :get_product_category, list_of(:pcategory_details) do
      arg(:user_token, non_null(:string))
      resolve(&Connect.Buisness.BuisnessResolver.get_pcategory_details/2)
    end

    field :get_product, list_of(:get_product_type) do
          arg(:user_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.get_product/2)
    end

    field :get_product_random, list_of(:get_product_type) do
          arg(:user_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.get_product_randomly/2)
    end

    field :get_service_category, list_of(:category) do
          arg(:user_token, non_null(:string))
          resolve(&Connect.Category.CategoryResolver.get_service_category/2)
    end

    field :get_buisness_details_by_category, list_of(:buisness_details) do
          arg(:user_token, non_null(:string))
          arg(:category_id, non_null(:integer))
          resolve(&Connect.Buisness.BuisnessResolver.get_buisness_details_by_category/2)
    end

    field :get_product_category_by_bid, list_of(:pcategory_details_by_bid) do
      arg(:buisness_id, non_null(:integer))
      resolve(&Connect.Buisness.BuisnessResolver.get_pcategory_details_by_buisness_id/2)
    end

    field :get_product_by_category_and_bid, list_of(:get_product_type) do
      arg(:buisness_id, non_null(:integer))
      arg(:category_token, non_null(:string))
      resolve(&Connect.Buisness.BuisnessResolver.get_product_by_category_and_bid/2)
    end
  end


  mutation do
    field :insert_buisness_data, type: :buisnees_data do
          arg(:category_id, non_null(:integer))
          arg(:description, non_null(:string))
          arg(:latitude, non_null(:float))
          arg(:location, non_null(:string))
          arg(:longitude, non_null(:float))
          arg(:shop_name, non_null(:string))
          arg(:user_token, non_null(:string))
          arg(:website_address, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.insert_buisness_data/2)
    end

    field :update_description, type: :description_type do
          arg(:description, non_null(:string))
          arg(:user_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.update_buisness_description/2)
    end

    field :update_location, type: :location_type do
          arg(:latitude, non_null(:float))
          arg(:longitude, non_null(:float))
          arg(:location, non_null(:string))
          arg(:user_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.update_buisness_location/2)
    end

    field :update_web_address, type: :web_address_type do
          arg(:website_address, non_null(:string))
          arg(:user_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.update_buisness_web_address/2)
    end

    field :insert_product_category, type: :product_category_type do
          arg(:category, non_null(:string))
          arg(:user_token, non_null(:string))
          arg(:category_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.insert_buisness_product_category/2)
    end

    field :update_product_category, type: :product_category_type do
          arg(:category, non_null(:string))
          arg(:user_token, non_null(:string))
          arg(:category_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.update_buisness_product_category/2)
    end

    field :delete_product_category, type: :product_category_delete_type do
          arg(:user_token, non_null(:string))
          arg(:category_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.delete_buisness_product_category/2)
    end

    field :insert_product, type: :product_type do
          arg(:user_token, non_null(:string))
          arg(:product_token, non_null(:string))
          arg(:buttton_type, non_null(:string))
          arg(:category_token, non_null(:string))
          arg(:is_available, non_null(:boolean))
          arg(:offer_price, non_null(:integer))
          arg(:p_description, non_null(:string))
          arg(:price, non_null(:integer))
          arg(:product_name, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.insert_product/2)
    end

    field :update_product, type: :product_type do
          arg(:user_token, non_null(:string))
          arg(:product_token, non_null(:string))
          arg(:buttton_type, non_null(:string))
          arg(:category_token, non_null(:string))
          arg(:is_available, non_null(:boolean))
          arg(:offer_price, non_null(:integer))
          arg(:p_description, non_null(:string))
          arg(:price, non_null(:integer))
          arg(:product_name, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.update_product/2)
    end

    field :delete_product, type: :p_delete_type do
          arg(:user_token, non_null(:string))
          arg(:product_token, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.delete_product/2)
    end

     field :update_buisness_data, type: :buisnees_data do
          arg(:category_id, non_null(:integer))
          arg(:description, non_null(:string))
          arg(:latitude, non_null(:float))
          arg(:location, non_null(:string))
          arg(:longitude, non_null(:float))
          arg(:shop_name, non_null(:string))
          arg(:user_token, non_null(:string))
          arg(:website_address, non_null(:string))
          resolve(&Connect.Buisness.BuisnessResolver.update_buisness_data/2)
    end
  end
end