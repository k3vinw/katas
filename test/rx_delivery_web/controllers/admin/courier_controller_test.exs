defmodule RxDeliveryWeb.Admin.CourierControllerTest do
  use RxDeliveryWeb.ConnCase

  alias RxDelivery.Admin

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{company_id: -1}

  def fixture(:courier) do
    {:ok, courier} = Admin.create_courier(@create_attrs)
    courier
  end

  describe "index" do
    test "lists all couriers", %{conn: conn} do
      conn = get(conn, Routes.admin_courier_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Couriers"
    end
  end

  describe "new courier" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_courier_path(conn, :new))
      assert html_response(conn, 200) =~ "New Courier"
    end
  end

  describe "create courier" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_courier_path(conn, :create), courier: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_courier_path(conn, :show, id)

      conn = get(conn, Routes.admin_courier_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Courier"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_courier_path(conn, :create), courier: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Courier"
    end
  end

  describe "edit courier" do
    setup [:create_courier]

    test "renders form for editing chosen courier", %{conn: conn, courier: courier} do
      conn = get(conn, Routes.admin_courier_path(conn, :edit, courier))
      assert html_response(conn, 200) =~ "Edit Courier"
    end
  end

  describe "update courier" do
    setup [:create_courier]

    test "redirects when data is valid", %{conn: conn, courier: courier} do
      conn = put(conn, Routes.admin_courier_path(conn, :update, courier), courier: @update_attrs)
      assert redirected_to(conn) == Routes.admin_courier_path(conn, :show, courier)

      conn = get(conn, Routes.admin_courier_path(conn, :show, courier))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, courier: courier} do
      conn = put(conn, Routes.admin_courier_path(conn, :update, courier), courier: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Courier"
    end
  end

  describe "delete courier" do
    setup [:create_courier]

    test "deletes chosen courier", %{conn: conn, courier: courier} do
      conn = delete(conn, Routes.admin_courier_path(conn, :delete, courier))
      assert redirected_to(conn) == Routes.admin_courier_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_courier_path(conn, :show, courier))
      end
    end
  end

  defp create_courier(_) do
    courier = fixture(:courier)
    {:ok, courier: courier}
  end
end
