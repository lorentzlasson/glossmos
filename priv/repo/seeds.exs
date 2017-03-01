alias Glossmos.Repo
alias Glossmos.Gloss
alias Glossmos.GlossSet

Repo.delete_all Gloss

# ~w(gloss gloss_set gloss_set_bulk)
# |> Enum.map(fn(f) ->
#   File.read!("sample_data/#{f}.json")
#   |> Poison.decode!
# end)
# |> List.flatten
# |> IO.inspect

g = File.read!("sample_data/gloss.json")
|> Poison.decode!
Gloss.changeset(%Gloss{}, g)
|> Repo.insert

File.read!("sample_data/gloss_set.json")
|> Poison.decode!
|> GlossSet.changesets
|> GlossSet.insert

File.read!("sample_data/gloss_set_bulk.json")
|> Poison.decode!
|> GlossSet.changesets_bulk
|> GlossSet.insert_bulk
