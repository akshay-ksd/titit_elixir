defmodule Connect.ProductCategories do
  use Ecto.Schema
  import Ecto.{Query, Changeset}, warn: false
  alias Connect.ProductCategories
  
  schema "product_categories" do
    field :buisness_id, :integer
    field :category_name, :string
    field :category_token, :string
    field :is_disabled, :boolean, default: false

    timestamps()
  end
  
  def insert_buisness_product_category(category,b_id,category_token) do 
    %Connect.ProductCategories{
     category_name: category,
     buisness_id: b_id,
     category_token: category_token
    }
    |> Connect.Repo.insert()
  end
 
  def update_buisness_product_category(category,b_id,category_token) do
    Connect.Repo.get_by(ProductCategories, buisness_id: b_id, category_token: category_token)
    |> Ecto.Changeset.change(%{category_name: category})
    |> Connect.Repo.update()
  end
  
  def delete_buisness_product_category(b_id,category_token) do
    data = Connect.Repo.get_by(ProductCategories, buisness_id: b_id, category_token: category_token)
    Connect.Repo.delete(data)
  end

  def get_pcategory_data(b_id) do
    from(u in ProductCategories, where: u.buisness_id == ^b_id)
    |> Connect.Repo.all()
  end

  @doc false
  def changeset(product_categories, attrs) do
    product_categories
    |> cast(attrs, [:buisness_id, :category_name, :category_token, :is_disabled])
    |> validate_required([:buisness_id, :category_name, :category_token, :is_disabled])
  end
end
