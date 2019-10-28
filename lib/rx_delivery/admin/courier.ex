defmodule RxDelivery.Admin.Courier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "couriers" do
    field :company_id, :integer

    timestamps()
  end

  @doc false
  def changeset(courier, attrs) do
    courier
    |> cast(attrs, [:company_id])
    |> validate_required([:company_id])
  end
end
