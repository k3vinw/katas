defmodule RxDelivery.Repo.Migrations.CreateCouriers do
  use Ecto.Migration

  def change do
    create table(:couriers) do
      add :company_id, :integer

      timestamps()
    end

  end
end
