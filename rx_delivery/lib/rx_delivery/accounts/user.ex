defmodule RxDelivery.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RxDelivery.Admin.Pharmacy
  alias RxDelivery.Admin.Courier
  alias Argon2

  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    belongs_to :pharmacy, Pharmacy
    belongs_to :courier, Courier

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password, :pharmacy_id, :courier_id])
    |> validate_required([:username, :encrypted_password])
    |> foreign_key_constraint(:pharmacy_id)
    |> foreign_key_constraint(:courier_id)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{encrypted_password: encrypted_password}} = changeset) do
    change(changeset, encrypted_password: Argon2.hash_pwd_salt(encrypted_password))
  end

  defp put_password_hash(changeset), do: changeset
end
