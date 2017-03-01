defmodule Glossmos.GlossSetController do
  use Glossmos.Web, :controller

  alias Glossmos.GlossSet
  alias Glossmos.Gloss

  def show(conn, %{"id" => key}) do
    glosses = Gloss |> where(key: ^key) |> Repo.all
    render conn, "sets.json", glosses: glosses
  end

  def index(conn, _params) do
    glosses = Gloss |> Repo.all
    render conn, "sets.json", glosses: glosses
  end

  def create(conn, params) do
    cs_set = params |> unwrap_list |> GlossSet.changesets
    i_cs = cs_set |> Gloss.invalid_changeset

    if i_cs do
      render conn, "error.json", changeset: i_cs
    else
      case GlossSet.insert(cs_set) do
        {:error, cs} ->
          render conn, "error.json", changeset: cs
        {:ok, glosses} ->
          render conn, "sets.json", glosses: glosses
      end
    end
  end

  def create_bulk(conn, params) do
    cs_bulk = params |> unwrap_list |> GlossSet.changesets_bulk
    i_cs = cs_bulk |> List.flatten |> Gloss.invalid_changeset

    if i_cs do
      render conn, "error.json", changeset: i_cs
    else
      case GlossSet.insert_bulk(cs_bulk) do
        {:error, cs} ->
          render conn, "error.json", changeset: cs
        {:ok, glosses} ->
          render conn, "sets.json", glosses: glosses
      end
    end
  end

  defp unwrap_list(%{"_json" => list}), do: list
end
