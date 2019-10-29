defmodule RxDeliveryWeb.Admin.PharmacyController do
  use RxDeliveryWeb, :controller

  alias RxDelivery.Admin
  alias RxDelivery.Admin.Pharmacy

  def index(conn, _params) do
    pharmacies = Admin.list_pharmacies()
    render(conn, "index.html", pharmacies: pharmacies)
  end

  def new(conn, _params) do
    changeset = Admin.change_pharmacy(%Pharmacy{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pharmacy" => pharmacy_params}) do
    case Admin.create_pharmacy(pharmacy_params) do
      {:ok, pharmacy} ->
        conn
        |> put_flash(:info, "Pharmacy created successfully.")
        |> redirect(to: Routes.admin_pharmacy_path(conn, :show, pharmacy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pharmacy = Admin.get_pharmacy!(id)
    render(conn, "show.html", pharmacy: pharmacy)
  end

  def edit(conn, %{"id" => id}) do
    pharmacy = Admin.get_pharmacy!(id)
    changeset = Admin.change_pharmacy(pharmacy)
    render(conn, "edit.html", pharmacy: pharmacy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pharmacy" => pharmacy_params}) do
    pharmacy = Admin.get_pharmacy!(id)

    case Admin.update_pharmacy(pharmacy, pharmacy_params) do
      {:ok, pharmacy} ->
        conn
        |> put_flash(:info, "Pharmacy updated successfully.")
        |> redirect(to: Routes.admin_pharmacy_path(conn, :show, pharmacy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pharmacy: pharmacy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pharmacy = Admin.get_pharmacy!(id)
    {:ok, _pharmacy} = Admin.delete_pharmacy(pharmacy)

    conn
    |> put_flash(:info, "Pharmacy deleted successfully.")
    |> redirect(to: Routes.admin_pharmacy_path(conn, :index))
  end
end
