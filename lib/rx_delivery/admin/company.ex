defmodule RxDelivery.Admin.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :address_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :address_id])
    |> validate_required([:name, :address_id])
  end
end
