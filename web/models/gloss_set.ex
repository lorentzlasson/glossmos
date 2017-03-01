defmodule Glossmos.GlossSet do
  import Ecto.Changeset

  alias Glossmos.Gloss

  def changeset(gloss, params \\ %{}) do
    gloss
    |> cast(params, [:text, :language])
    |> validate_required([:text, :language])
  end

  def insert(cs_set), do: cs_set |> add_key |> Gloss.insert_all

  def insert_bulk(cs_bulk) do
    cs_bulk |> Enum.map(&add_key/1) |> List.flatten |> Gloss.insert_all
  end

  def changesets_bulk(bulk), do: bulk |> Enum.map(&changesets/1)

  def changesets(set) do
    Enum.map(set, fn(x) ->
      changeset(%Gloss{}, x)
    end)
  end

  defp add_key(set) do
    key = Gloss.gen_key()
    Enum.map(set, fn(cs) ->
      Gloss.add_key(cs, key)
    end)
  end
end
