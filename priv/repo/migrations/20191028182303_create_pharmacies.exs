defmodule RxDelivery.Repo.Migrations.CreatePharmacies do
  use Ecto.Migration

  def change do
    create table(:pharmacies) do
      add :company_id, :integer

      timestamps()
    end

  end
end
