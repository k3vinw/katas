defmodule RxDelivery.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RxDelivery.Admin.Company

  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password, :company_id])
    |> validate_required([:username, :encrypted_password, :company_id])
    |> foreign_key_constraint(:company_id)
    |> unique_constraint(:username)
  end
end
