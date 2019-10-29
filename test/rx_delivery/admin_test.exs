defmodule RxDelivery.AdminTest do
  use RxDelivery.DataCase

  alias RxDelivery.Admin

  describe "companies" do
    alias RxDelivery.Admin.Company

    @valid_attrs %{address_id: 42, name: "some name"}
    @update_attrs %{address_id: 43, name: "some updated name"}
    @invalid_attrs %{address_id: nil, name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Admin.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Admin.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Admin.create_company(@valid_attrs)
      assert company.address_id == 42
      assert company.name == "some name"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Admin.update_company(company, @update_attrs)
      assert company.address_id == 43
      assert company.name == "some updated name"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_company(company, @invalid_attrs)
      assert company == Admin.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Admin.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Admin.change_company(company)
    end
  end

  describe "pharmacies" do
    alias RxDelivery.Admin.Pharmacy

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{company_id: -1}

    def pharmacy_fixture(attrs \\ %{}) do
      {:ok, pharmacy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_pharmacy()

      pharmacy
    end

    test "list_pharmacies/0 returns all pharmacies" do
      pharmacy = pharmacy_fixture()
      assert Admin.list_pharmacies() == [pharmacy]
    end

    test "get_pharmacy!/1 returns the pharmacy with given id" do
      pharmacy = pharmacy_fixture()
      assert Admin.get_pharmacy!(pharmacy.id) == pharmacy
    end

    test "create_pharmacy/1 with valid data creates a pharmacy" do
      assert {:ok, %Pharmacy{} = pharmacy} = Admin.create_pharmacy(@valid_attrs)
      assert pharmacy
    end

    test "create_pharmacy/1 with non-existant company returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_pharmacy(@invalid_attrs)
    end

    test "update_pharmacy/2 with valid data updates the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{} = pharmacy} = Admin.update_pharmacy(pharmacy, @update_attrs)
      assert pharmacy
    end

    test "update_pharmacy/2 with non-existant company returns error changeset" do
      pharmacy = pharmacy_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_pharmacy(pharmacy, @invalid_attrs)
      assert pharmacy == Admin.get_pharmacy!(pharmacy.id)
    end

    test "delete_pharmacy/1 deletes the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{}} = Admin.delete_pharmacy(pharmacy)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_pharmacy!(pharmacy.id) end
    end

    test "change_pharmacy/1 returns a pharmacy changeset" do
      pharmacy = pharmacy_fixture()
      assert %Ecto.Changeset{} = Admin.change_pharmacy(pharmacy)
    end
  end

  describe "couriers" do
    alias RxDelivery.Admin.Courier

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{company_id: -1}

    def courier_fixture(attrs \\ %{}) do
      {:ok, courier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_courier()

      courier
    end

    test "list_couriers/0 returns all couriers" do
      courier = courier_fixture()
      assert Admin.list_couriers() == [courier]
    end

    test "get_courier!/1 returns the courier with given id" do
      courier = courier_fixture()
      assert Admin.get_courier!(courier.id) == courier
    end

    test "create_courier/1 with valid data creates a courier" do
      assert {:ok, %Courier{} = courier} = Admin.create_courier(@valid_attrs)
      assert courier
    end

    test "create_courier/1 with non-existant company returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_courier(@invalid_attrs)
    end

    test "update_courier/2 with valid data updates the courier" do
      courier = courier_fixture()
      assert {:ok, %Courier{} = courier} = Admin.update_courier(courier, @update_attrs)
      assert courier
    end

    test "update_courier/2 with invalid data returns error changeset" do
      courier = courier_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_courier(courier, @invalid_attrs)
      assert courier == Admin.get_courier!(courier.id)
    end

    test "delete_courier/1 deletes the courier" do
      courier = courier_fixture()
      assert {:ok, %Courier{}} = Admin.delete_courier(courier)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_courier!(courier.id) end
    end

    test "change_courier/1 returns a courier changeset" do
      courier = courier_fixture()
      assert %Ecto.Changeset{} = Admin.change_courier(courier)
    end
  end

  describe "addresses" do
    alias RxDelivery.Admin.Address

    @valid_attrs %{address: "some address", city: "some city", name: "some name", state: "some state", zip: "some zip"}
    @update_attrs %{address: "some updated address", city: "some updated city", name: "some updated name", state: "some updated state", zip: "some updated zip"}
    @invalid_attrs %{address: nil, city: nil, name: nil, state: nil, zip: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Admin.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Admin.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Admin.create_address(@valid_attrs)
      assert address.address == "some address"
      assert address.city == "some city"
      assert address.name == "some name"
      assert address.state == "some state"
      assert address.zip == "some zip"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Admin.update_address(address, @update_attrs)
      assert address.address == "some updated address"
      assert address.city == "some updated city"
      assert address.name == "some updated name"
      assert address.state == "some updated state"
      assert address.zip == "some updated zip"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_address(address, @invalid_attrs)
      assert address == Admin.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Admin.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Admin.change_address(address)
    end
  end
end
