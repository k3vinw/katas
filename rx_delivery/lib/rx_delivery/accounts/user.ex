defmodule RxDelivery.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RxDelivery.Admin.Pharmacy
  alias RxDelivery.Admin.Courier

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
  end
end
