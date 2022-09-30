defmodule ConnectWeb.AuthenticationController do
  use ConnectWeb, :controller
 
  alias Connect.UserProfile
  require Logger
  alias Connect.BuisnessDetails 
  alias Connect.Buisness_category                  
  alias Connect.Guardian
  # plug :validate_user_type

  def authenticate(conn, %{"phone" => phone, "user_name" => user_name, "profile_image_url" => profile_image_url}) do
    with {:ok, user} <- UserProfile.get_or_create(phone, user_name, profile_image_url),
         {:ok, token, _claims} = Connect.Guardian.encode_and_sign(user),
         UserProfile.update_token(phone, token, user_name, profile_image_url) do
          # conn
          #   |> json(%{
          #       "id" => user.id,
          #       "token" => token,
          #       "user_name" => user_name,
          #       "profile_image_url" => profile_image_url,
          #       "is_buisness_created" => false,
          #       "category_name" => "false"
          #   })
         if user.is_buisness_created == true do
            {:ok, buisness_details} = BuisnessDetails.get_id_by_user_id(user.id)
            category_id = buisness_details.category_id
            # {:ok, category} = Buisness_category.get_category_by_id(category_id)
            conn
            |> json(%{
                "id" => user.id,
                "token" => token,
                "user_name" => user_name,
                "profile_image_url" => profile_image_url,
                "is_buisness_created" => user.is_buisness_created,
                "category_name" => "category.category_name"
            })
          else
           conn
            |> json(%{
                "id" => user.id,
                "token" => token,
                "user_name" => user_name,
                "profile_image_url" => profile_image_url,
                "is_buisness_created" => false,
                "category_name" => "false"
            })
         end
         else 
            {:error, reason} ->
            conn
            |> json(%{"error" => "Error authenticating: #{reason}"})
    end
  end
  
  
  def validate_token(conn, %{"token" => token, "user_id" => user_id}) do
     with {:ok, user} <- UserProfile.get_token_by_user_id(user_id) do
      user_token = String.replace(token, ~s("), "")
      if user_token == user.token do
        conn
         |> json(%{
             "status" => true,
         })
      else 
       conn
         |> json(%{
             "status" => false,
         })
      end
       
       else 
            {:error, reason} ->
            conn
            |> json(%{"error" => "Error authenticating: #{reason}"})
      end
  end

  defp token_status(token) do
    ConnectWeb.Endpoint.broadcast!("user:" <> token, "user_cred", %{status: false})
    Logger.info token
  end
end