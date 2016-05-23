defmodule Concoctify.User do
  use Concoctify.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params ~w(username email)
  @optional_params ~w(first_name last_name)

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_params, @optional_params)
    |> validate_length(:username, min: 1, max: 20)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
