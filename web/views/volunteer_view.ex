defmodule Slamscheduler.VolunteerView do
  use Slamscheduler.Web, :view

  def render("index.json", %{volunteers: volunteers}) do
    volunteers
  end
end
