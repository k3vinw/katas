defmodule RxDelivery.Repo.Migrations.AssociateAddressesToPharmsCouriers do
  use Ecto.Migration

  def change do
    alter table(:pharmacies) do
      add :address_id, references(:addresses)
    end
    alter table(:couriers) do
      add :address_id, references(:addresses)
    end
  end
end
