defmodule RxDeliveryWeb.Router do
  use RxDeliveryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # Our pipeline implements "maybe" authenticated.
  # We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug RxDelivery.Accounts.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RxDeliveryWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout

    resources "/users", UserController
  end

  scope "/admin", RxDeliveryWeb.Admin, as: :admin do
    pipe_through [:browser, :auth]
    resources "/pharmacies", PharmacyController
    resources "/couriers", CourierController
    resources "/addresses", AddressController
  end

  scope "/dms", RxDeliveryWeb.DMS, as: :dms do
    pipe_through [:browser, :auth]
    resources "/patients", PatientController
    resources "/orders", OrderController
  end

  scope "/", RxDeliveryWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/protected", PageController, :protected
  end

  # Other scopes may use custom stacks.
  # scope "/api", RxDeliveryWeb do
  #   pipe_through :api
  # end
end
