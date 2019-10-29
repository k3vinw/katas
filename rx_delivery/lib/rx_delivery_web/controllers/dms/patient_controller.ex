defmodule RxDeliveryWeb.DMS.PatientController do
  use RxDeliveryWeb, :controller

  alias RxDelivery.DMS
  alias RxDelivery.DMS.Patient

  def index(conn, _params) do
    patients = DMS.list_patients()
    render(conn, "index.html", patients: patients)
  end

  def new(conn, _params) do
    changeset = DMS.change_patient(%Patient{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"patient" => patient_params}) do
    case DMS.create_patient(patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient created successfully.")
        |> redirect(to: Routes.dms_patient_path(conn, :show, patient))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = DMS.get_patient!(id)
    render(conn, "show.html", patient: patient)
  end

  def edit(conn, %{"id" => id}) do
    patient = DMS.get_patient!(id)
    changeset = DMS.change_patient(patient)
    render(conn, "edit.html", patient: patient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = DMS.get_patient!(id)

    case DMS.update_patient(patient, patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient updated successfully.")
        |> redirect(to: Routes.dms_patient_path(conn, :show, patient))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", patient: patient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = DMS.get_patient!(id)
    {:ok, _patient} = DMS.delete_patient(patient)

    conn
    |> put_flash(:info, "Patient deleted successfully.")
    |> redirect(to: Routes.dms_patient_path(conn, :index))
  end
end
