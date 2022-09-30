defmodule Connect.Repo.Migrations.CreateBuisnessDetails do
  use Ecto.Migration

  def change do
    create table(:buisness_details) do
      add :category_id, :integer
      add :description, :text
      add :latitude, :float
      add :location, :text
      add :longitude, :float
      add :shop_name, :text
      add :user_id, :integer
      add :website_address, :text
      add :is_desabled, :boolean, default: false, null: false

      timestamps()
    end

  end
end
