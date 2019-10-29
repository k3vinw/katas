defmodule RxDelivery.Admin.Courier do
  use Ecto.Schema
  import Ecto.Changeset
  alias RxDelivery.Admin.Address

  schema "couriers" do
    field :name, :string
    has_one :address, Address

    timestamps()
  end

  @doc false
  def changeset(courier, attrs) do
    courier
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
