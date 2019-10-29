defmodule RxDelivery.Repo.Migrations.AddNamesToPharmsCouriers do
  use Ecto.Migration

  def change do
    alter table(:pharmacies) do
      add :name, :string
    end
    alter table(:couriers) do
      add :name, :string
    end
  end
end
