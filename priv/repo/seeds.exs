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
alias Concoctify.IngredientType

defmodule Concoctify.Seeder do
  def seed(changeset) do
    case Repo.insert(changeset) do
      {:ok, model} ->
        IO.puts "Created new #{model.__struct__}: #{model.name}"
        model
      {:error, changeset} -> {:error, changeset}
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

concoction_type_names
|> Enum.each(fn(concoction_type_name) ->
  changeset = ConcoctionType.changeset(%ConcoctionType{}, %{name: concoction_type_name})

  Concoctify.Seeder.seed(changeset)
end)

#------------------------------------------------------------------------------
# Make IngredientProducers
#------------------------------------------------------------------------------
[
  "Delitaliana Food Products",
  "Generic",
  "Herritage Honey", "Homegrown", "Homemade",
  "Kingsburg Honey",
  "Simply Balanced",
  "Unknown"
]
|> Enum.each(fn(ingredient_producer_name) ->
  changeset = IngredientProducer.changeset(%IngredientProducer{}, %{name: ingredient_producer_name})

  Concoctify.Seeder.seed(changeset)
end)

#------------------------------------------------------------------------------
# Make IngredientTypes
#------------------------------------------------------------------------------
# [
#   "Cotton",
#   "Orange Blossom",
#   "Raspberry"
# ]
[
  "apple",
  "apricot",
  "cherry",
  "cinnamon",
  "honey",
  "fig",
  "lemon",
  "nectarine",
  "orange",
  "peach",
]
|> Enum.each(fn(ingredient_type_name) ->
  changeset = IngredientType.changeset(%IngredientType{}, %{name: ingredient_type_name})
  Concoctify.Seeder.seed(changeset)
end)

#------------------------------------------------------------------------------
# Make Honies
#------------------------------------------------------------------------------
# [
#   %{producer: "Unknown", variety: "Cotton"},
#   %{producer: "Unknown", variety: "Orange Blossom"},
#   %{producer: "Herritage Honey", variety: "Raspberry"}
# ]
# |> Enum.each(fn(honey) ->
#   changeset = Honey.changeset(%Honey{}, %{name: honey})
#   Concoctify.Seeder.seed(changeset)
# end)

#------------------------------------------------------------------------------
# Make BaseCommodities and CommodityVarieties
#------------------------------------------------------------------------------
# commodity_attribs = [
#   %{name: "Apple", variety_name: "Pink Lady"},
#   %{name: "Apple", variety_name: "Unknown"},
#   %{name: "Apricot", variety_name: "Unknown"},
#   %{name: "Cherry", variety_name: "Bing"},
#   %{name: "Cherry", variety_name: "Unknown"},
#   %{name: "Cinnamon", variety_name: "Ceylon"},
#   %{name: "Cinnamon", variety_name: "Unknown"},
#   %{name: "Fig", variety_name: "Black Mission"},
#   %{name: "Fig", variety_name: "Unknown"},
#   %{name: "Lemon", variety_name: "Meyer"},
#   %{name: "Lemon", variety_name: "Unknown"},
#   %{name: "Nectarine", variety_name: "Unknown"},
#   %{name: "Orange", variety_name: "Blood"},
#   %{name: "Orange", variety_name: "Unknown"},
#   %{name: "Peach", variety_name: "Summer Flame"},
#   %{name: "Peach", variety_name: "Unknown"}
# ]

# commodity_attribs
# |> Enum.each(fn(attribs) ->
#   base_commodity_changeset = BaseCommodity.changeset(%BaseCommodity{}, %{name: attribs.name})

#   Concoctify.Seeder.seed(base_commodity_changeset)
# end)

# commodity_attribs
# |> Enum.each(fn(attribs) ->
#   base_commodity = Repo.get_by! BaseCommodity, name: attribs.name
#   IO.inspect base_commodity.id

#   changeset = CommodityVariety.changeset(%CommodityVariety{},
#     %{name: attribs.name, commodity_id: base_commodity.id})
#   Concoctify.Seeder.seed(changeset)
# end)

# commodity_attribs = [
#   %{name: "Apple",    variety_name: "Pink Lady",      producer_name: "Unknown"},
#   %{name: "Apple",    variety_name: "Unknown",        producer_name: "Unknown"},
#   %{name: "Apricot",  variety_name: "Unknown",        producer_name: "Unknown"},
#   %{name: "Cherry",   variety_name: "Bing",           producer_name: "Unknown"},
#   %{name: "Cherry",   variety_name: "Unknown",        producer_name: "Unknown"},
#   %{name: "Cinnamon", variety_name: "Ceylon",         producer_name: "Unknown"},
#   %{name: "Cinnamon", variety_name: "Unknown",        producer_name: "Unknown"},
#   %{name: "Fig",      variety_name: "Black Mission",  producer_name: "Unknown"},
#   %{name: "Fig",      variety_name: "Unknown",        producer_name: "Unknown"},
#   %{name: "Lemon",    variety_name: "Meyer",          producer_name: "Unknown"},
#   %{name: "Lemon",    variety_name: "Unknown",        producer_name: "Unknown"},
#   %{name: "Nectarine", variety_name: "Unknown",       producer_name: "Unknown"},
#   %{name: "Orange",   variety_name: "Blood",          producer_name: "Unknown"},
#   %{name: "Orange",   variety_name: "Unknown",        producer_name: "Unknown"},
#   %{name: "Peach",    variety_name: "Summer Flame",   producer_name: "Unknown"},
#   %{name: "Peach",    variety_name: "Unknown",        producer_name: "Unknown"}
# ]

#------------------------------------------------------------------------------
# Make Commodities
#------------------------------------------------------------------------------
# commodity_names = [
#   "Apple",
#   "Apricot",
#   "Banana",
#   "Blueberry",
#   "Boysenberry",
#   "Cherry",
#   "Cinnamon",
#   "Fig",
#   "Grape",
#   "Honey",
#   "Lemon",
#   "Nectarine",
#   "Orange",
#   "Peach",
#   "Raisin",
#   "Raspberry",
#   "Rhubarb",
#   "Strawberry",
#   "Sugar",
#   "Vanilla Bean"
# ]

# Enum.each commodity_names, fn(commodity_name) ->
#   changeset = Commodity.changeset(%Commodity{}, %{name: commodity_name})
#   Concoctify.Seeder.seed(changeset)
# end

 #------------------------------------------------------------------------------
 # Make Ingredients
 #------------------------------------------------------------------------------
# commodity_attribs = [
#   %{commodity_name: "Apple",      variety_name: "Pink Lady"},
#   %{commodity_name: "Apple",      variety_name: "Unknown"},
#   %{commodity_name: "Apricot",    variety_name: "Unknown"},
#   %{commodity_name: "Cherry",     variety_name: "Bing"},
#   %{commodity_name: "Cherry",     variety_name: "Unknown"},
#   %{commodity_name: "Cinnamon",   variety_name: "Ceylon"},
#   %{commodity_name: "Cinnamon",   variety_name: "Unknown"},
#   %{commodity_name: "Fig",        variety_name: "Black Mission"},
#   %{commodity_name: "Fig",        variety_name: "Unknown"},
#   %{commodity_name: "Lemon",      variety_name: "Meyer"},
#   %{commodity_name: "Lemon",      variety_name: "Unknown"},
#   %{commodity_name: "Nectarine",  variety_name: "Unknown"},
#   %{commodity_name: "Orange",     variety_name: "Blood"},
#   %{commodity_name: "Orange",     variety_name: "Unknown"},
#   %{commodity_name: "Peach",      variety_name: "Summer Flame"},
#   %{commodity_name: "Peach",      variety_name: "Unknown"},
#   %{commodity_name: "Rhubarb",    variety_name: "Unknown"},
#   %{commodity_name: "Strawberry", variety_name: "Unknown"},
# ]

 # Enum.each ingredient_brand_names, fn(ingredient_brand_name) ->
 #   changeset = IngredientBrand.changeset(%IngredientBrand{}, %{name: ingredient_brand_name})

 #   case Repo.insert(changeset) do
 #     {:ok, _model} -> IO.puts "Created new concoction type: #{ingredient_brand_name}"
 #     {:error, _changeset} -> {:error, _changeset}
 #   end
 # end
