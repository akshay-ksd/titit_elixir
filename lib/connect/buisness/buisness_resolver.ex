defmodule Connect.Buisness.BuisnessResolver do
  alias Connect.BuisnessDetails                   
  alias Connect.UserProfile
  alias Connect.ProductCategories
  alias Connect.Products
  require Logger

  def insert_buisness_data(%{category_id: category_id,
                            description: description,
                            latitude: latitude,
                            location: location,
                            longitude: longitude,
                            shop_name: shop_name,
                            user_token: user_token,
                            website_address: website_address}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    UserProfile.update_buisness_status(user_id)
    {:ok, data} = BuisnessDetails.insert_buisness_data(category_id,description,latitude,location,longitude,shop_name,user_id,website_address)
  end

  def update_buisness_description(%{description: description,user_token: user_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    BuisnessDetails.update_buisness_description(description,user_id)
  end

  def update_buisness_location(%{latitude: latitude,longitude: longitude,location: location,user_token: user_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    BuisnessDetails.update_buisness_location(latitude,longitude,location,user_id)
  end

  def update_buisness_web_address(%{website_address: website_address,user_token: user_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    BuisnessDetails.update_buisness_web_address(website_address,user_id)
  end

  def insert_buisness_product_category(%{category: category,user_token: user_token,category_token: category_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id
    ProductCategories.insert_buisness_product_category(category,b_id,category_token)
  end
  
  def update_buisness_product_category(%{category: category,user_token: user_token,category_token: category_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id
    ProductCategories.update_buisness_product_category(category,b_id,category_token)
  end

  def delete_buisness_product_category(%{user_token: user_token,category_token: category_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id
    ProductCategories.delete_buisness_product_category(b_id,category_token)
  end

  def insert_product(%{user_token: user_token,
                       product_token: product_token,
                       buttton_type: buttton_type,
                       category_token: category_token,
                       is_available: is_available,
                       offer_price: offer_price,
                       p_description: p_description,
                       price: price,
                       product_name: product_name}, _info) do

    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id

    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id

    Products.insert_product(b_id,
                            product_token,
                            buttton_type,
                            category_token,
                            is_available,
                            offer_price,
                            p_description,
                            price,
                            product_name)
  end

  def update_product(%{user_token: user_token,
                       product_token: product_token,
                       buttton_type: buttton_type,
                       category_token: category_token,
                       is_available: is_available,
                       offer_price: offer_price,
                       p_description: p_description,
                       price: price,
                       product_name: product_name}, _info) do

    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id

    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id
    Products.update_product(b_id,
                            product_token,
                            buttton_type,
                            category_token,
                            is_available,
                            offer_price,
                            p_description,
                            price,
                            product_name)
  end

  def delete_product(%{user_token: user_token,product_token: product_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
      user_id = user.id

    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id

    Products.delete_product(b_id,product_token)
  end

   def update_buisness_data(%{category_id: category_id,
                            description: description,
                            latitude: latitude,
                            location: location,
                            longitude: longitude,
                            shop_name: shop_name,
                            user_token: user_token,
                            website_address: website_address}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    {:ok, data} = BuisnessDetails.update_buisness_data(category_id,description,latitude,location,longitude,shop_name,user_id,website_address)
  end

  def get_buisness_data(%{user_token: user_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id
    {:ok, BuisnessDetails.get_buisness_data(user_id)}
  end

  def get_pcategory_details(%{user_token: user_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id

    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id
    
    {:ok, ProductCategories.get_pcategory_data(b_id)}
  end

  def get_product(%{user_token: user_token}, _info) do
    {:ok, user} = UserProfile.get_id_by_token(user_token) 
    user_id = user.id

    {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user_id)
    b_id = buisness_details.id
    
    {:ok, Products.get_product_data(b_id)}
  end

  def get_product_randomly(%{user_token: user_token}, _info) do
    # {:ok, user} = UserProfile.get_id_by_token(user_token) 
    # user_id = user.id
    {:ok, Products.get_product_data_randomly()}
  end

  def get_buisness_details_by_category(%{user_token: user_token,category_id: category_id}, _info) do
    # {:ok, user} = UserProfile.get_id_by_token(user_token) 
    # user_id = user.id
    {:ok, BuisnessDetails.get_buisness_details_by_category()}
  end

  def get_pcategory_details_by_buisness_id(%{buisness_id: b_id}, _info) do
    {:ok, ProductCategories.get_pcategory_data(b_id)}
  end

  def get_product_by_category_and_bid(%{buisness_id: buisness_id,category_token: category_token}, _info) do
    {:ok, Products.get_product_by_category_and_bid(buisness_id,category_token)}
  end
end
