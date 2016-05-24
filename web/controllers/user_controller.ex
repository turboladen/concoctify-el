defmodule Concoctify.UserController do
  use Concoctify.Web, :controller
  alias Concoctify.User

  def index(conn, _params) do
    users = Repo.all(Concoctify.User)
    render conn, "index.html", users: users
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.username} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Concoctify.User, id)
    render conn, "show.html", user: user
  end
end
