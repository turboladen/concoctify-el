defmodule Concoctify.HoneyVarietyTest do
  use Concoctify.ModelCase

  alias Concoctify.HoneyVariety

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = HoneyVariety.changeset(%HoneyVariety{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = HoneyVariety.changeset(%HoneyVariety{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with duplicate name" do
    changeset1 = HoneyVariety.changeset(%HoneyVariety{}, @valid_attrs)
    {:ok, _model} = Concoctify.Repo.insert changeset1

    changeset2 = HoneyVariety.changeset(%HoneyVariety{}, @valid_attrs)
    {:error, changeset2} = Concoctify.Repo.insert changeset2
    assert changeset2.errors == [name: "has already been taken"]
  end
end
