defmodule RxDeliveryWeb.DMS.OrderControllerTest do
  use RxDeliveryWeb.ConnCase

  alias RxDelivery.DMS

  @create_attrs %{patient_id: 42, pickup: ~D[2010-04-17], status: "some status", user_id: 42}
  @update_attrs %{patient_id: 43, pickup: ~D[2011-05-18], status: "some updated status", user_id: 43}
  @invalid_attrs %{patient_id: nil, pickup: nil, status: nil, user_id: nil}

  def fixture(:order) do
    {:ok, order} = DMS.create_order(@create_attrs)
    order
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.dms_order_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Orders"
    end
  end

  describe "new order" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.dms_order_path(conn, :new))
      assert html_response(conn, 200) =~ "New Order"
    end
  end

  describe "create order" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dms_order_path(conn, :create), order: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.dms_order_path(conn, :show, id)

      conn = get(conn, Routes.dms_order_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dms_order_path(conn, :create), order: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Order"
    end
  end

  describe "edit order" do
    setup [:create_order]

    test "renders form for editing chosen order", %{conn: conn, order: order} do
      conn = get(conn, Routes.dms_order_path(conn, :edit, order))
      assert html_response(conn, 200) =~ "Edit Order"
    end
  end

  describe "update order" do
    setup [:create_order]

    test "redirects when data is valid", %{conn: conn, order: order} do
      conn = put(conn, Routes.dms_order_path(conn, :update, order), order: @update_attrs)
      assert redirected_to(conn) == Routes.dms_order_path(conn, :show, order)

      conn = get(conn, Routes.dms_order_path(conn, :show, order))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put(conn, Routes.dms_order_path(conn, :update, order), order: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Order"
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, Routes.dms_order_path(conn, :delete, order))
      assert redirected_to(conn) == Routes.dms_order_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.dms_order_path(conn, :show, order))
      end
    end
  end

  defp create_order(_) do
    order = fixture(:order)
    {:ok, order: order}
  end
end
