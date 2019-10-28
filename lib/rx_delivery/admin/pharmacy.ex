defmodule RxDelivery.Admin.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pharmacies" do
    field :company_id, :integer

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:company_id])
    |> validate_required([:company_id])
  end
end
