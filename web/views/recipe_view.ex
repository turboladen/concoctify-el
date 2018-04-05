defmodule Concoctify.RecipeView do
  use Concoctify.Web, :view

  def concoction_type_names do
    Concoctify.ConcoctionType.names
  end
end
