defmodule RxDelivery.DMS.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :address_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name, :address_id])
    |> validate_required([:name, :address_id])
  end
end
