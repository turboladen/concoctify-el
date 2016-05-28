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
alias Concoctify.GeneralIngredient

defmodule Concoctify.Seeder do
  def seed(changeset) do
    case Repo.insert(changeset) do
      {:ok, model} -> IO.puts "Created new #{model.__struct__}: #{model.name}"
      {:error, _changeset} -> {:error, _changeset}
    end
  end
end

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

  Concoctify.Seeder.seed(changeset)
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

  Concoctify.Seeder.seed(changeset)
end

#------------------------------------------------------------------------------
# Make GeneralIngredients
#------------------------------------------------------------------------------
general_ingredient_names = [
  "Apricot",
  "Cherry",
  "Honey",
  "Lemon",
  "Maple Syrup",
  "Orange",
  "Pectic Enzyme",
  "Raisin",
  "Rhubarb",
  "Strawberry",
  "Sugar",
  "Vanilla Bean",
  "Water"
]

Enum.each general_ingredient_names, fn(general_ingredient_name) ->
  changeset = GeneralIngredient.changeset(%GeneralIngredient{}, %{name: general_ingredient_name})
  Concoctify.Seeder.seed(changeset)
end
