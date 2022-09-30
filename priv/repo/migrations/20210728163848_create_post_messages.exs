defmodule Connect.Repo.Migrations.CreatePostMessages do
  use Ecto.Migration

  def change do
    create table(:post_messages) do
      add :chat, :text
      add :contact_name, :string
      add :contact_number, :string
      add :image_url, :text
      add :thumbnail_url, :text
      add :type, :string
      add :user_token, :text
      add :video_url, :text
      add :recieved, :boolean, default: false, null: false
      add :local_id, :text
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end

  end
end
