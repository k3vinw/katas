defmodule RxDelivery.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string
      add :address_id, :integer

      timestamps()
    end

  end
end
