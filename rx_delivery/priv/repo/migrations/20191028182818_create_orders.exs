defmodule RxDelivery.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :pickup, :date
      add :status, :string
      add :user_id, :integer
      add :patient_id, :integer

      timestamps()
    end

  end
end
