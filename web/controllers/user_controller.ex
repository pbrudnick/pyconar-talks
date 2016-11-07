defmodule PyconarTalks.UserController do
  use PyconarTalks.Web, :controller

  def new(conn, params, current_user, _claims) do
    render conn, "new.html", current_user: current_user
  end
end