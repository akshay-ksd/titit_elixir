defmodule ConnectWeb.Resolvers.Products do
  alias Connect.Buisness_category
  alias Connect.BuisnessList
  require Logger

  def list_category(_args, _context) do
    {:ok, Buisness_category.get_buisness_category()}
  end
end