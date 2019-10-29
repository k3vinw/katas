defmodule RxDelivery.Admin.Courier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "couriers" do
    field :address_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(courier, attrs) do
    courier
    |> cast(attrs, [:name, :address_id])
    |> validate_required([:name, :address_id])
  end
end
