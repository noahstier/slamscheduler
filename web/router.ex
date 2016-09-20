defmodule Slamscheduler2.Router do
  use Slamscheduler2.Web, :router

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

  scope "/", Slamscheduler2 do
    pipe_through :browser # Use the default browser stack

    get "/", ScheduleController, :index

    delete "/volunteers", VolunteersController, :delete
    post "/volunteers", VolunteersController, :create
    patch "/volunteers", VolunteersController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", Slamscheduler2 do
  #   pipe_through :api
  # end
end
