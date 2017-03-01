require IEx
defmodule Glossmos.GlossController do
  use Glossmos.Web, :controller

  alias Glossmos.Gloss

  def show(conn, %{"id" => id}) do
    gloss = Repo.get Gloss, id
    render conn, "show.json", gloss: gloss
  end

  def index(conn, _params) do
    glosses = Gloss |> Repo.all
    render conn, "index.json", glosses: glosses
  end

  def create(conn, params) do
    changeset = Gloss.changeset(%Gloss{}, params)
    case Repo.insert(changeset) do
      {:ok, gloss} ->
        render conn, "show.json", gloss: gloss
      {:error, changeset} ->
        render conn, "error.json", changeset: changeset
    end
  end

  def delete_all(conn, _params) do
    {count, _} = Gloss |> Repo.delete_all
    render conn, "delete_all.json", count: count
  end
end
