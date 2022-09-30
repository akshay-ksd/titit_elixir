defmodule ConnectWeb.Router do
  use ConnectWeb, :router

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
  
  pipeline :graphql do
    # Will be used later
  end
  
  scope "/api", ConnectWeb do
    pipe_through :api

    post "/authenticate", AuthenticationController, :authenticate
    post "/validate_token", AuthenticationController, :validate_token
  end
  
  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: ConnectWeb.Schema
  end

  if Mix.env == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: ConnectWeb.Schema
  end
  # Other scopes may use custom stacks.
  # scope "/api", ConnectWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ConnectWeb.Telemetry
    end
  end
end
