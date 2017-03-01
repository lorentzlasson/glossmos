defmodule Glossmos.GlossView do
  use Glossmos.Web, :view

  def render("show.json", %{gloss: gloss}) do
    gloss |> gloss_json
  end

  def render("index.json", %{glosses: glosses}) do
    Enum.map(glosses, &gloss_json/1)
  end

  def render("delete_all.json", %{count: count}) do
    %{
      count: count
    }
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
