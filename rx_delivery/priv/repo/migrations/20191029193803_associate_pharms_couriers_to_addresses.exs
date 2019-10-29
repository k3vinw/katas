defmodule RxDelivery.Repo.Migrations.AssociatePharmsCouriersToAddresses do
  use Ecto.Migration

  def change do
    alter table(:addresses) do
      add :pharmacy_id, references(:pharmacies)
      add :courier_id, references(:couriers)
    end
  end
end
