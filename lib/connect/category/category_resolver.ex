defmodule Connect.Category.CategoryResolver do
  alias Connect.Buisness_category                    #import lib/graphql/accounts/accounts.ex as Accounts

  def all(_args, _info) do
    {:ok, Buisness_category.get_buisness_category()}
  end

   def get_service_category(%{user_token: user_token}, _info) do
    # {:ok, user} = UserProfile.get_id_by_token(user_token) 
    # user_id = user.id
    {:ok, Buisness_category.get_service_category()}
  end

end