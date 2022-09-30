defmodule Connect.Repo.Migrations.CreateProductCategories do
  use Ecto.Migration

  def change do
    create table(:product_categories) do
      add :buisness_id, :integer
      add :category_name, :text
      add :category_token, :text
      add :is_disabled, :boolean, default: false, null: false

      timestamps()
    end

  end
end
