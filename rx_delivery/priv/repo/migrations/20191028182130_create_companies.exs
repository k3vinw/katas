defmodule RxDelivery.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :address_id, :integer

      timestamps()
    end

  end
end
