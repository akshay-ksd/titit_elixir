defmodule Connect.Repo.Migrations.CreatePostData do
  use Ecto.Migration

  def change do
    create table(:post_data) do
      add :emergency, :boolean, default: false, null: false
      add :image_url, :text
      add :latitude, :float
      add :longitude, :float
      add :user_token, :text
      add :video_thumbnail, :text
      add :video_url, :text
      add :local_id, :text
      add :post, :text
      add :responce, :integer
      add :sharing_location_latitude, :float
      add :sharing_location_longitude, :float

      timestamps()
    end

  end
end
