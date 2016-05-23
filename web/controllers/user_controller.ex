defmodule Concoctify.UserController do
  use Concoctify.Web, :controller

  def index(conn, _params) do
    users = Repo.all(Concoctify.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Concoctify.User, id)
    render conn, "show.html", user: user
  end
end
