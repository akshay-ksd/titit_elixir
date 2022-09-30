defmodule Connect.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Connect.User

  schema "users" do
    field :phone, :string
    field :user_name, :string
    timestamps()
  end
  
  def get_or_create(phone, user_name) do
    case Connect.Repo.get_by(User, phone: phone, user_name: user_name) do
      nil ->
      %User{phone: phone, user_name: user_name}
      |> Connect.Repo.insert()
      user ->
      {:ok, user}
    end
  end
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_name, :phone])
    |> validate_required([:user_name, :phone])
  end
end
