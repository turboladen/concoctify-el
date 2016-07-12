defmodule Concoctify.ConcoctionTypeTest do
  use Concoctify.ModelCase

  alias Concoctify.ConcoctionType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{stuff: 1}

  test "changeset with valid attributes" do
    changeset = ConcoctionType.changeset(%ConcoctionType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ConcoctionType.changeset(%ConcoctionType{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with duplicate name" do
    changeset1 = ConcoctionType.changeset(%ConcoctionType{}, @valid_attrs)
    {:ok, _model} = Concoctify.Repo.insert changeset1

    changeset2 = ConcoctionType.changeset(%ConcoctionType{}, @valid_attrs)
    {:error, changeset2} = Concoctify.Repo.insert changeset2
    assert changeset2.errors == [name: "has already been taken"]
  end
end
