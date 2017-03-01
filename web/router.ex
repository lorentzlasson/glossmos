defmodule Glossmos.Router do
  use Glossmos.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Glossmos do
    pipe_through :api

    delete "/gloss/all", GlossController, :delete_all
    resources "/gloss", GlossController, only: [:create, :index, :show]
  end
end
