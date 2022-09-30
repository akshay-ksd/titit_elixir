defmodule Connect.Guardian do
  use Guardian, otp_app: :connect

  def subject_for_token(%{id: user_id}, _claims) do
    {:ok, user_id}
  end

  def resource_from_claims(%{"sub" => subject}) do
    case Connect.Repo.get(Connect.UserProfile, subject) do
        nill -> {:error, :not_found}
        user_profile -> {:ok, user_profile}           
    end
  end
end