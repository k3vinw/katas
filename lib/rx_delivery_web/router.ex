defmodule RxDeliveryWeb.Router do
  use RxDeliveryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RxDeliveryWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/admin", RxDeliveryWeb.Admin, as: :admin do
    pipe_through :browser
    resources "/companies", CompanyController
    resources "/pharmacies", PharmacyController
    resources "/couriers", CourierController
  end

  scope "/dms", RxDeliveryWeb.DMS, as: :dms do
    pipe_through :browser
    resources "/patients", PatientController
    resources "/orders", OrderController
  end

  # Other scopes may use custom stacks.
  # scope "/api", RxDeliveryWeb do
  #   pipe_through :api
  # end
end
