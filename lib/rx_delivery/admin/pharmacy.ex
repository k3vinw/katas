defmodule RxDelivery.Admin.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pharmacies" do
    belongs_to :company, RxDelivery.Admin.Company

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:company_id])
    |> foreign_key_constraint(:company_id)
  end
end
