defmodule RxDelivery.Admin.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pharmacies" do
    field :address_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name, :address_id])
    |> validate_required([:name, :address_id])
  end
end
