defmodule Glossmos.GlossSetView do
  use Glossmos.Web, :view

  def render("sets.json", %{glosses: glosses}) do
    glosses
    |> Enum.map(&gloss_json/1)
    |> Enum.group_by(&(&1.key))
  end

  def render("set.json", %{glosses: glosses}) do
    glosses
    |> Enum.map(&gloss_json/1)
    |> Enum.group_by(&(&1.key))

    glosses |> Enum.map(&gloss_json/1)
  end

  def render("error.json", %{changeset: %{errors: errors, changes: changes}}) do
    %{
      offences: Enum.map(errors, &pretty_offence/1),
      source: changes |> Map.drop([:key])
    }
  end

  defp pretty_offence({field, {offence, _}}) do
    "#{field} #{offence}"
  end

  defp gloss_json(gloss) do
    %{
      id: gloss.id,
      language: gloss.language,
      text: gloss.text,
      key: gloss.key
    }
  end
end
