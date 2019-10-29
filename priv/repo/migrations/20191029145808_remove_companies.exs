defmodule RxDelivery.Repo.Migrations.RemoveCompanies do
  use Ecto.Migration

  def change do
    execute "alter table users drop constraint users_company_id_fkey"
    alter table(:users) do
      remove :company_id
      add :pharmacy_id, references(:pharmacies)
      add :courier_id, references(:couriers)
    end

    execute "alter table pharmacies drop constraint pharmacies_company_id_fkey"
    alter table(:pharmacies) do
      remove :company_id
      add :pharmacy_id, references(:pharmacies)
      add :courier_id, references(:couriers)
    end

    execute "alter table couriers drop constraint couriers_company_id_fkey"
    alter table(:couriers) do
      remove :company_id
      add :pharmacy_id, references(:pharmacies)
      add :courier_id, references(:couriers)
    end
  end
end
