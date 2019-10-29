defmodule RxDeliveryWeb.UserController do
  use RxDeliveryWeb, :controller

  alias RxDelivery.Accounts
  alias RxDelivery.Accounts.User
  alias RxDelivery.Admin

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    pharmacies = Admin.list_pharmacies
      |> Enum.map(&{&1.name, &1.id})
    couriers = Admin.list_couriers
      |> Enum.map(&{&1.name, &1.id})
    render(conn, "new.html", changeset: changeset,
      pharmacies: pharmacies,
      couriers: couriers)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        pharmacies = Admin.list_pharmacies
          |> Enum.map(&{&1.name, &1.id})
        couriers = Admin.list_couriers
          |> Enum.map(&{&1.name, &1.id})
        render(conn, "new.html", changeset: changeset,
          pharamacies: pharmacies,
          couriers: couriers)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    pharmacy = case user.pharmacy_id do
      id when id !== nil ->
        Admin.get_phrmacy!(id)
      _ ->
        %{name: ""}
    end
    courier = case user.courier_id do
      id when id !== nil ->
        Admin.get_courier!(id)
      _ ->
        %{name: ""}
    end
    render(conn, "show.html", user: user,
      pharmacy: pharmacy,
      courier: courier)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    pharmacies = Admin.list_pharmacies
      |> Enum.map(&{&1.name, &1.id})
    couriers = Admin.list_couriers
      |> Enum.map(&{&1.name, &1.id})
    render(conn, "edit.html", user: user, changeset: changeset,
      pharmacies: pharmacies,
      couriers: couriers)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        pharmacies = Admin.list_pharmacies
          |> Enum.map(&{&1.name, &1.id})
        couriers = Admin.list_couriers
          |> Enum.map(&{&1.name, &1.id})
        render(conn, "edit.html", user: user, changeset: changeset,
          pharmacies: pharmacies,
          couriers: couriers)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
