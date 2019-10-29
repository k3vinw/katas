defmodule RxDelivery.Repo.Migrations.AddCompanyIdReferences do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :company_id, references(:companies)
    end

    alter table(:pharmacies) do
      remove :company_id
      add :company_id, references(:companies)
    end

    alter table(:couriers) do
      remove :company_id
      add :company_id, references(:companies)
    end
  end
end
