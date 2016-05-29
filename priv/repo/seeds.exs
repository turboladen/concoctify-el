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
alias Concoctify.IngredientVariety
alias Concoctify.Commodity

defmodule Concoctify.Seeder do
  def seed(changeset) do
    case Repo.insert(changeset) do
      {:ok, model} ->
        IO.puts "Created new #{model.__struct__}: #{model.name}"
        model
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
  "Apple",
  "Apricot",
  "Cherry",
  "Cinnamon",
  "Fig",
  "Honey",
  "Lemon",
  "Maple Syrup",
  "Nectarine",
  "Orange",
  "Peach",
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

#------------------------------------------------------------------------------
# Make Ingredients
#------------------------------------------------------------------------------
ingredient_variety_attribs = [
  %{general_name: "Apple", name: "Pink Lady"},
  %{general_name: "Apple", name: "Unknown"},
  %{general_name: "Cherry", name: "Bing"},
  %{general_name: "Cherry", name: "Unknown"},
  %{general_name: "Cinnamon", name: "Ceylon"},
  %{general_name: "Cinnamon", name: "Unknown"},
  %{general_name: "Fig", name: "Black Mission"},
  %{general_name: "Fig", name: "Unknown"},
  %{general_name: "Honey", name: "Cotton"},
  %{general_name: "Honey", name: "Orange Blossom"},
  %{general_name: "Honey", name: "Raspberry"},
  %{general_name: "Honey", name: "Sage"},
  %{general_name: "Honey", name: "Wildflower"},
  %{general_name: "Honey", name: "Unknown"},
  %{general_name: "Lemon", name: "Meyer"},
  %{general_name: "Lemon", name: "Unknown"},
  %{general_name: "Nectarine", name: "Unknown"},
  %{general_name: "Orange", name: "Blood"},
  %{general_name: "Orange", name: "Unknown"},
  %{general_name: "Peach", name: "Summer Flame"},
  %{general_name: "Peach", name: "Unknown"},
]

Enum.each ingredient_variety_attribs, fn(attribs) ->
  general_ingredient = Repo.get_by!(GeneralIngredient, name: attribs.general_name)
  changeset = IngredientVariety.changeset(%IngredientVariety{},
    %{name: attribs.name, general_ingredient_id: general_ingredient.id})
  Concoctify.Seeder.seed(changeset)
end

#------------------------------------------------------------------------------
# Make Commodities
#------------------------------------------------------------------------------
commodity_names = [
  "Apple",
  "Apricot",
  "Banana",
  "Blueberry",
  "Boysenberry",
  "Cherry",
  "Cinnamon",
  "Fig",
  "Grape",
  "Honey",
  "Lemon",
  "Nectarine",
  "Orange",
  "Peach",
  "Raisin",
  "Raspberry",
  "Rhubarb",
  "Strawberry",
  "Sugar",
  "Vanilla Bean"
]

Enum.each commodity_names, fn(commodity_name) ->
  changeset = Commodity.changeset(%Commodity{}, %{name: commodity_name})
  Concoctify.Seeder.seed(changeset)
end
