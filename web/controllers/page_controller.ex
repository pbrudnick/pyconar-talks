defmodule PyconarTalks.PageController do
  use PyconarTalks.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
