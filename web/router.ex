defmodule PyconarTalks.Router do
  use PyconarTalks.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # This pipeline if intended for API requests and looks for the JWT in the "Authorization" header
  # In this case, it should be prefixed with "Bearer" so that it's looking for
  # Authorization: Bearer <jwt>
  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PyconarTalks do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", PyconarTalks do
    pipe_through [:api]

    resources "/talks", TalkController, except: [:delete, :update]
    # post "/talks/vote/:talk_id", TalkController, :vote
    get "/scores", ScoreController, :index
    get "/scores/talks", ScoreController, :talks_by_score
    get "/scores/:id", ScoreController, :show
    post "/scores", ScoreController, :create
    #resources "/scores", ScoreController, except: [:delete, :update]
  end
end
