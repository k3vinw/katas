defmodule RxDeliveryWeb.Admin.CourierController do
  use RxDeliveryWeb, :controller

  alias RxDelivery.Admin
  alias RxDelivery.Admin.Courier

  def index(conn, _params) do
    couriers = Admin.list_couriers()
    render(conn, "index.html", couriers: couriers)
  end

  def new(conn, _params) do
    changeset = Admin.change_courier(%Courier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"courier" => courier_params}) do
    case Admin.create_courier(courier_params) do
      {:ok, courier} ->
        conn
        |> put_flash(:info, "Courier created successfully.")
        |> redirect(to: Routes.admin_courier_path(conn, :show, courier))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    courier = Admin.get_courier!(id)
    render(conn, "show.html", courier: courier)
  end

  def edit(conn, %{"id" => id}) do
    courier = Admin.get_courier!(id)
    changeset = Admin.change_courier(courier)
    render(conn, "edit.html", courier: courier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "courier" => courier_params}) do
    courier = Admin.get_courier!(id)

    case Admin.update_courier(courier, courier_params) do
      {:ok, courier} ->
        conn
        |> put_flash(:info, "Courier updated successfully.")
        |> redirect(to: Routes.admin_courier_path(conn, :show, courier))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", courier: courier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    courier = Admin.get_courier!(id)
    {:ok, _courier} = Admin.delete_courier(courier)

    conn
    |> put_flash(:info, "Courier deleted successfully.")
    |> redirect(to: Routes.admin_courier_path(conn, :index))
  end
end
