defmodule Glossmos.Gloss do
  use Glossmos.Web, :model

  alias Glossmos.Repo

  schema "glosses" do
    field :language
    field :text
    field :key

    timestamps()
  end

  def changeset(gloss, params \\ %{}) do
    gloss
    |> cast(params, [:text, :language, :key])
    |> validate_required([:text, :language])
    |> ensure_key
  end

  def ensure_key(cs) do
    case get_change cs, :key do
      nil ->
        add_key cs, gen_key()
      _ ->
        cs
    end
  end

  def add_key(cs, key), do: change cs, key: key
  def gen_key(), do: Ecto.UUID.generate()

  def invalid_changeset(cs_list), do: cs_list |> Enum.find(&(!&1.valid?))

  def insert_all([next| tail]), do: next |> Repo.insert |> _insert_all([], tail)
  defp _insert_all({:error, _} = res, _, _), do: res
  defp _insert_all({:ok, cs}, acc, []), do: {:ok, [cs | acc]}
  defp _insert_all({:ok, cs}, acc, [next | tail]) do
    next |> Repo.insert |> _insert_all([cs| acc], tail)
  end
end
