defmodule RxDeliveryWeb.SessionController do
  use RxDeliveryWeb, :controller

  alias RxDelivery.{Accounts, Accounts.User, Accounts.Guardian}

  def new(conn, _) do
    changeset = Accounts.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      redirect(conn, to: "/protected")
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"username" => username, "encrypted_password" => encrypted_password}}) do
    Accounts.authenticate_user(username, encrypted_password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out() 
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> IO.inspect
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/protected")
    |> IO.inspect
  end
                                               
  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end