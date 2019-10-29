defmodule RxDelivery.Repo.Migrations.AssociationsForOrdersPharmCouriers do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :pharmacy_id, references(:pharmacies)
    end
  end
end
