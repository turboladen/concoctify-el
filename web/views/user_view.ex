defmodule Concoctify.UserView do
  use Concoctify.Web, :view
  alias Concoctify.User

  def full_name(%User{first_name: first_name, last_name: last_name}) do
    "#{first_name} #{last_name}"
  end
end
