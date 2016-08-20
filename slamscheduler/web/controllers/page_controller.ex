defmodule Slamscheduler.PageController do
  use Slamscheduler.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
