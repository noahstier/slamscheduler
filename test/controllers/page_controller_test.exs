defmodule Slamscheduler.PageControllerTest do
  use Slamscheduler.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<div id=\"elm-main\"></div>"
  end
end
