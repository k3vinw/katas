defmodule RxDelivery.DMSTest do
  use RxDelivery.DataCase

  alias RxDelivery.DMS

  describe "patients" do
    alias RxDelivery.DMS.Patient

    @valid_attrs %{address_id: 42, name: "some name"}
    @update_attrs %{address_id: 43, name: "some updated name"}
    @invalid_attrs %{address_id: nil, name: nil}

    def patient_fixture(attrs \\ %{}) do
      {:ok, patient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DMS.create_patient()

      patient
    end

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert DMS.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert DMS.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      assert {:ok, %Patient{} = patient} = DMS.create_patient(@valid_attrs)
      assert patient.address_id == 42
      assert patient.name == "some name"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DMS.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{} = patient} = DMS.update_patient(patient, @update_attrs)
      assert patient.address_id == 43
      assert patient.name == "some updated name"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = DMS.update_patient(patient, @invalid_attrs)
      assert patient == DMS.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = DMS.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> DMS.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = DMS.change_patient(patient)
    end
  end

  describe "orders" do
    alias RxDelivery.DMS.Order

    @valid_attrs %{patient_id: 42, pickup: ~D[2010-04-17], status: "some status", user_id: 42}
    @update_attrs %{patient_id: 43, pickup: ~D[2011-05-18], status: "some updated status", user_id: 43}
    @invalid_attrs %{patient_id: nil, pickup: nil, status: nil, user_id: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DMS.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert DMS.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert DMS.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = DMS.create_order(@valid_attrs)
      assert order.patient_id == 42
      assert order.pickup == ~D[2010-04-17]
      assert order.status == "some status"
      assert order.user_id == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DMS.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = DMS.update_order(order, @update_attrs)
      assert order.patient_id == 43
      assert order.pickup == ~D[2011-05-18]
      assert order.status == "some updated status"
      assert order.user_id == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = DMS.update_order(order, @invalid_attrs)
      assert order == DMS.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = DMS.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> DMS.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = DMS.change_order(order)
    end
  end
end
