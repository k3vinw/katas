defmodule RxDelivery.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :name, :string
      add :address, :string
      add :city, :string
      add :state, :string
      add :zip, :string

      timestamps()
    end

  end
end
