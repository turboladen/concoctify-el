defmodule Concoctify.ConcoctionTypeTest do
  use Concoctify.ModelCase

  alias Concoctify.ConcoctionType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ConcoctionType.changeset(%ConcoctionType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ConcoctionType.changeset(%ConcoctionType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
