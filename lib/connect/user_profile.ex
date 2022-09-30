defmodule Connect.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Connect.UserProfile
  schema "userprofile" do
    field :image_url, :string
    field :is_buisness_created, :boolean, default: false
    field :phone, :string
    field :spam_count, :integer
    field :token, :string
    field :user_name, :string

    timestamps()
  end
 def get_or_create(phone, user_name, profile_image_url) do
    case Connect.Repo.get_by(UserProfile, phone: phone) do
      nil ->
      %UserProfile{phone: phone, user_name: user_name, image_url: profile_image_url, spam_count: 0}
      |> Connect.Repo.insert()
      user_profile ->
      {:ok, user_profile}
    end
  end
 
  def update_token(phone, token, user_name, profile_image_url) do
    Connect.Repo.get_by(UserProfile, phone: phone)
    |> Ecto.Changeset.change(%{token: token, user_name: user_name, image_url: profile_image_url})
    |> Connect.Repo.update()
  end

  def get_token_by_user_id(user_id) do
     case Connect.Repo.get_by(UserProfile, id: user_id) do
      nil ->
       {:ok, "no token"}
      user_profile ->
       {:ok, user_profile}
     end
  end

   def get_id_by_token(token) do
     user_token = String.replace(token, ~s("), "")
     case Connect.Repo.get_by(UserProfile, token: user_token) do
      nil ->
       {:ok, "no id"}
      user_profile ->
       {:ok, user_profile}
     end
  end
  
  def update_buisness_status(user_id) do
      Connect.Repo.get_by(UserProfile, id: user_id)
      |> Ecto.Changeset.change(%{is_buisness_created: true})
      |> Connect.Repo.update()
  end

  @doc false
  def changeset(user_profile, attrs) do
    user_profile
    |> cast(attrs, [:image_url, :phone, :spam_count, :token, :user_name, :is_buisness_created])
    |> validate_required([:image_url, :phone, :spam_count, :token, :user_name, :is_buisness_created])
  end
end
