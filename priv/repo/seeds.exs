# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Concoctify.Repo.insert!(%Concoctify.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Concoctify.Repo
alias Concoctify.ConcoctionType
alias Concoctify.IngredientBrand

#------------------------------------------------------------------------------
# Make ConcoctionTypes
#------------------------------------------------------------------------------
fermented_types = ~w(
  Beer Cauim Chicha Cider Huangjiu Icariine
  Kasiri Kilju Kumis Mead Nihamanchi Pulque Parakari Sakurá Sake Sonti
  Tepache Tonto Tiswin Wine
)

distilled_types = ~w(Liqueur Spirit)
concoction_type_names = fermented_types ++ distilled_types

Enum.each concoction_type_names, fn(concoction_type_name) ->
  changeset = ConcoctionType.changeset(%ConcoctionType{}, %{name: concoction_type_name})

  case Repo.insert(changeset) do
    {:ok, _model} -> IO.puts "Created new concoction type: #{concoction_type_name}"
    {:error, _changeset} -> {:error, _changeset}
  end
end

#------------------------------------------------------------------------------
# Make IngredientBrands
#------------------------------------------------------------------------------
ingredient_brand_names = [
  "Delitaliana Food Products",
  "Generic",
  "Homegrown", "Homemade",
  "Simply Balanced"
]

Enum.each ingredient_brand_names, fn(ingredient_brand_name) ->
  changeset = IngredientBrand.changeset(%IngredientBrand{}, %{name: ingredient_brand_name})

  case Repo.insert(changeset) do
    {:ok, _model} -> IO.puts "Created new concoction type: #{ingredient_brand_name}"
    {:error, _changeset} -> {:error, _changeset}
  end
end
