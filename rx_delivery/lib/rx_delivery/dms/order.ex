defmodule RxDelivery.DMS.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :patient_id, :integer
    field :pickup, :date
    field :status, :string
    field :user_id, :integer
    belongs_to :pharmacy, RxDelivery.Admin.Pharmacy

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:pickup, :status, :user_id, :patient_id])
    |> validate_required([:pickup, :status, :user_id, :patient_id])
  end
end
