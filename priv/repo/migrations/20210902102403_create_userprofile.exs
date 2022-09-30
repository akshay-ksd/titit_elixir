defmodule Connect.Repo.Migrations.CreateUserprofile do
  use Ecto.Migration

  def change do
    create table(:userprofile) do
      add :image_url, :text
      add :phone, :text
      add :spam_count, :integer
      add :token, :text
      add :user_name, :text
      add :is_buisness_created, :boolean, default: false, null: false

      timestamps()
    end

  end
end
