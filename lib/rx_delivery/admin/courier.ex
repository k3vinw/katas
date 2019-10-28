defmodule RxDelivery.Admin.Courier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "couriers" do
    belongs_to :company, RxDelivery.Admin.Company

    timestamps()
  end

  @doc false
  def changeset(courier, attrs) do
    courier
    |> cast(attrs, [:company_id])
    |> foreign_key_constraint(:company_id)
  end
end
