defmodule Slamscheduler2.PageController do
  use Slamscheduler2.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
