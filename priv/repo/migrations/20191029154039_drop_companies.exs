defmodule RxDelivery.Repo.Migrations.DropCompanies do
  use Ecto.Migration

  def change do
    drop table(:companies)
  end
end
