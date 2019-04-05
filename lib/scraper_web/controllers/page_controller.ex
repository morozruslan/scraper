defmodule ScraperWeb.PageController do
  use ScraperWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
