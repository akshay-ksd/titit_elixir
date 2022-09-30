defmodule Connect.Buisness_category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Connect.Buisness_category

  schema "categories" do
    field :category_name, :string
    timestamps()
  end
  
   def create_category(user, %{"category_name" => category_name}) do
    %Connect.Buisness_category{
       category_name: category_name
    }
    |> Connect.Repo.insert()
  end

  def get_buisness_category() do
    Connect.Repo.all(Buisness_category)
  end
  
  def get_category_by_id(category_id) do
     case Connect.Repo.get_by(Buisness_category, id: category_id) do
      nil ->
       {:ok, "no category"}
      category ->
       {:ok, category}
     end
  end

  def get_service_category() do
     Connect.Repo.all(Buisness_category)
  end
  @doc false
  def changeset(buisness_category, attrs) do
    buisness_category
    |> cast(attrs, [:category_name])
    |> validate_required([:category_name])
  end
end
