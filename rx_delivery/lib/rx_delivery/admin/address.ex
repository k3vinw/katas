defmodule RxDelivery.Admin.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :address, :string
    field :city, :string
    field :name, :string
    field :state, :string
    field :zip, :string
    belongs_to :pharmacy, RxDelivery.Admin.Address
    belongs_to :courier, RxDelivery.Admin.Address

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :address, :city, :state, :zip])
    |> validate_required([:name, :address, :city, :state, :zip])
  end
end
