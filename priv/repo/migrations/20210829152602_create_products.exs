defmodule Connect.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :buisness_id, :integer
      add :category_token, :text
      add :product_name, :text
      add :p_description, :text
      add :price, :integer
      add :offer_price, :integer
      add :buttton_type, :string
      add :is_available, :boolean, default: false, null: false
      add :product_token, :text

      timestamps()
    end

  end
end
