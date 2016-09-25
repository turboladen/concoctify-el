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

defmodule Concoctify.Seeder do
  alias Concoctify.Repo
  alias Concoctify.ConcoctionType
  alias Concoctify.IngredientProducer
  alias Concoctify.IngredientType
  alias Concoctify.IngredientVariety
  alias Concoctify.UnusedIngredient

  #------------------------------------------------------------------------------
  # Make ConcoctionTypes
  #------------------------------------------------------------------------------
  def make_concoction_types do
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

      seed(changeset)
    end)
  end

  #------------------------------------------------------------------------------
  # Make IngredientProducers
  #------------------------------------------------------------------------------
  def make_ingredient_producers do
    [
      "Burkett's Polination",
      "Delitaliana Food Products",
      "Generic",
      "Heritage Honey", "Homegrown", "Homemade", "Honey Pacifica", "HMC",
      "Kingsburg Honey",
      "M & D Honey",
      "Shamrock's Bees", "Simply Balanced",
      "Unknown",
      "Whole Spice"
    ] |> Enum.each(fn(ingredient_producer_name) ->
      changeset = IngredientProducer.changeset(%IngredientProducer{}, %{name: ingredient_producer_name})

      seed(changeset)
    end)
  end

  #------------------------------------------------------------------------------
  # Make IngredientTypes
  #------------------------------------------------------------------------------
  def make_ingredient_types do
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
    ] |> Enum.each(fn(ingredient_type_name) ->
      changeset = IngredientType.changeset(%IngredientType{}, %{name: ingredient_type_name})
      seed(changeset)
    end)
  end

  #------------------------------------------------------------------------------
  # Make IngredientVarietys
  #------------------------------------------------------------------------------
  def make_ingredient_varieties do
    [
      %{ type_name: "apple", variety_name: "Pink Lady" },
      %{ type_name: "apricot", variety_name: "unknown" },
      %{ type_name: "cherry", variety_name: "Bing" },
      %{ type_name: "cinnamon", variety_name: "Ceylon" },
      %{ type_name: "honey", variety_name: "buckwheat" },
      %{ type_name: "honey", variety_name: "cotton" },
      %{ type_name: "honey", variety_name: "raspberry" },
      %{ type_name: "honey", variety_name: "orange blossom" },
      %{ type_name: "honey", variety_name: "sage" },
      %{ type_name: "honey", variety_name: "wildflower" },
      %{ type_name: "fig", variety_name: "Black Mission" },
      %{ type_name: "lemon", variety_name: "Meyer" },
      %{ type_name: "nectarine", variety_name: "Summer Flame" },
      %{ type_name: "orange", variety_name: "blood" },
      %{ type_name: "peach", variety_name: "Summer Flame" }
    ]
    |> Enum.each(fn(variety_attribs) ->
      type = Repo.get_by!(IngredientType, name: variety_attribs.type_name)
      changeset = IngredientVariety.changeset(%IngredientVariety{}, %{name: variety_attribs.variety_name, ingredient_type_id: type.id})
      seed(changeset)
    end)
  end

  #------------------------------------------------------------------------------
  # Make UnusedIngredients
  #------------------------------------------------------------------------------
  def make_unused_ingredients do
    [
      %{ type_name: "apple", variety_name: "Pink Lady", producer_name: "Unknown" },
      %{ type_name: "apricot", variety_name: "unknown", producer_name: "Unknown" },
      %{ type_name: "cherry", variety_name: "Bing", producer_name: "Unknown" },
      %{ type_name: "cinnamon", variety_name: "Ceylon", producer_name: "Whole Spice" },
      %{ type_name: "honey", variety_name: "buckwheat", producer_name: "Honey Pacifica" },
      %{ type_name: "honey", variety_name: "cotton", producer_name: "M & D Honey" },
      %{ type_name: "honey", variety_name: "orange blossom", producer_name: "Burkett's Polination" },
      %{ type_name: "honey", variety_name: "orange blossom", producer_name: "Shamrock's Bees" },
      %{ type_name: "honey", variety_name: "raspberry", producer_name: "Heritage Honey" },
      %{ type_name: "honey", variety_name: "sage", producer_name: "M & D Honey" },
      %{ type_name: "fig", variety_name: "Black Mission", producer_name: "Unknown" },
      %{ type_name: "lemon", variety_name: "Meyer", producer_name: "Homegrown" },
      %{ type_name: "nectarine", variety_name: "Summer Flame", producer_name: "HMC" },
      %{ type_name: "orange", variety_name: "blood", producer_name: "Homegrown" },
      %{ type_name: "peach", variety_name: "Summer Flame", producer_name: "HMC" },
    ]
    |> Enum.each(fn(ingredient_attribs) ->
      type = Repo.get_by!(IngredientType, name: ingredient_attribs.type_name)
      variety = Repo.get_by!(IngredientVariety, name: ingredient_attribs.variety_name, ingredient_type_id: type.id)
      producer = Repo.get_by!(IngredientProducer, name: ingredient_attribs.producer_name)

      IO.puts("type: #{type.name}")
      IO.puts("type: #{type.id}")
      IO.puts("variety name: #{variety.name}")
      IO.puts("variety id: #{variety.id}")
      IO.puts("producer id: #{producer.id}")
      IO.puts("producer name: #{producer.name}")

      changeset = UnusedIngredient.changeset(%UnusedIngredient{},
        %{ingredient_variety_id: variety.id, ingredient_producer_id: producer.id})

      {:ok, model} = seed(changeset)
    end)
  end

  defp seed(changeset) do
    case Repo.insert(changeset) do
      {:ok, model} ->
        IO.puts "Created new #{model.__struct__}: #{model.id}"

        {:ok, model}
      {:error, changeset} ->
        IO.puts "ERRORRRRR"
        {:error, changeset}
    end
  end
end


Concoctify.Seeder.make_concoction_types
Concoctify.Seeder.make_ingredient_producers
Concoctify.Seeder.make_ingredient_types
Concoctify.Seeder.make_ingredient_varieties
Concoctify.Seeder.make_unused_ingredients

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
