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
alias Concoctify.IngredientProducer
alias Concoctify.HoneyVariety
alias Concoctify.Honey
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
  Kasiri Kilju Kumis Mead Nihamanchi Perry Pulque Parakari Sakurá Sake Sonti
  Tepache Tonto Tiswin Wine
)

distilled_types = ~w(Liqueur Spirit)
concoction_type_names = fermented_types ++ distilled_types

Enum.each concoction_type_names, fn(concoction_type_name) ->
  changeset = ConcoctionType.changeset(%ConcoctionType{}, %{name: concoction_type_name})

  Concoctify.Seeder.seed(changeset)
end

#------------------------------------------------------------------------------
# Make IngredientProducers
#------------------------------------------------------------------------------
ingredient_producer_names = [
  "Delitaliana Food Products",
  "Generic",
  "Herritage Honey", "Homegrown", "Homemade",
  "Kingsburg Honey",
  "Simply Balanced",
  "Unknown"
]

Enum.each ingredient_producer_names, fn(ingredient_producer_name) ->
  changeset = IngredientProducer.changeset(%IngredientProducer{}, %{name: ingredient_producer_name})

  Concoctify.Seeder.seed(changeset)
end

#------------------------------------------------------------------------------
# Make HoneyVarieties
#------------------------------------------------------------------------------
honey_variety_names = [
  "Cotton",
  "Orange Blossom",
  "Raspberry"
]

Enum.each honey_variety_names, fn(honey_variety_name) ->
  changeset = HoneyVariety.changeset(%HoneyVariety{}, %{name: honey_variety_name})
  Concoctify.Seeder.seed(changeset)
end

#------------------------------------------------------------------------------
# Make Honeies
#------------------------------------------------------------------------------
honies = [
  %{producer: "Unknown", variety: "Cotton"},
  %{producer: "Unknown", variety: "Orange Blossom"},
  %{producer: "Herritage Honey", variety: "Raspberry"}
]

Enum.each honies, fn(honey) ->
  changeset = Honey.changeset(%Honey{}, %{name: honey})
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
