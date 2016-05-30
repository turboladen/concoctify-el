defmodule Concoctify.BaseCommodityTest do
  use Concoctify.ModelCase

  alias Concoctify.BaseCommodity

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BaseCommodity.changeset(%BaseCommodity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BaseCommodity.changeset(%BaseCommodity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
