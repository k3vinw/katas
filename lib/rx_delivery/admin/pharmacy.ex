defmodule RxDelivery.Admin.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset
  alias RxDelivery.Admin.Address

  schema "pharmacies" do
    field :name, :string
    has_many :addresses, Address

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
