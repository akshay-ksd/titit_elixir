defmodule Connect.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_name, :text

      timestamps()
    end

  end
end
