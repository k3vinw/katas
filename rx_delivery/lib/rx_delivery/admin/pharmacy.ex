defmodule RxDelivery.Admin.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset
  alias RxDelivery.Admin.{Address,Courier}
  alias RxDelivery.DMS.Order

  schema "pharmacies" do
    field :name, :string
    has_one :address, Address
    belongs_to :courier, Courier
    has_many :orders, Order

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
