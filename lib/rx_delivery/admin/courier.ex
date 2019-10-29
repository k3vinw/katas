defmodule RxDelivery.Admin.Courier do
  use Ecto.Schema
  import Ecto.Changeset
  alias RxDelivery.Admin.{Address,Pharmacy}

  schema "couriers" do
    field :name, :string
    has_one :address, Address
    has_many :pharmacies, Pharmacy

    timestamps()
  end

  @doc false
  def changeset(courier, attrs) do
    courier
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
