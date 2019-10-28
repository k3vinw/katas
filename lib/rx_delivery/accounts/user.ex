defmodule RxDelivery.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    belongs_to :company, RxDelivery.Admin.Company

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password, :company_id])
    |> validate_required([:username, :encrypted_password])
    |> foreign_key_constraint(:company_id)
    |> unique_constraint(:username)
  end
end
