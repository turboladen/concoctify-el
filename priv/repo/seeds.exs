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
alias Concoctify.IngredientVariety
alias Concoctify.BaseCommodity
alias Concoctify.CommodityVariety
alias Concoctify.Commodity

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
# Make BaseCommodities and CommodityVarieties
#------------------------------------------------------------------------------
commodity_attribs = [
  %{name: "Apple", variety_name: "Pink Lady"},
  %{name: "Apple", variety_name: "Unknown"},
  %{name: "Apricot", variety_name: "Unknown"},
  %{name: "Cherry", variety_name: "Bing"},
  %{name: "Cherry", variety_name: "Unknown"},
  %{name: "Cinnamon", variety_name: "Ceylon"},
  %{name: "Cinnamon", variety_name: "Unknown"},
  %{name: "Fig", variety_name: "Black Mission"},
  %{name: "Fig", variety_name: "Unknown"},
  %{name: "Lemon", variety_name: "Meyer"},
  %{name: "Lemon", variety_name: "Unknown"},
  %{name: "Nectarine", variety_name: "Unknown"},
  %{name: "Orange", variety_name: "Blood"},
  %{name: "Orange", variety_name: "Unknown"},
  %{name: "Peach", variety_name: "Summer Flame"},
  %{name: "Peach", variety_name: "Unknown"}
]

Enum.each commodity_attribs, fn(attribs) ->
  base_commodity_changeset = BaseCommodity.changeset(%BaseCommodity{}, %{name: attribs.name})

  case Concoctify.Seeder.seed(base_commodity_changeset) do
    {:error, _base_changeset} ->
      base_commodity = Repo.get_by! BaseCommodity, name: attribs.name
      IO.inspect base_commodity.id

      changeset = CommodityVariety.changeset(%CommodityVariety{},
        %{name: attribs.name, commodity_id: base_commodity.id})
      Concoctify.Seeder.seed(changeset)
    base_commodity ->
      changeset = CommodityVariety.changeset(%CommodityVariety{},
       %{name: attribs.name, commodity_id: base_commodity.id})
      Concoctify.Seeder.seed(changeset)
  end
end
