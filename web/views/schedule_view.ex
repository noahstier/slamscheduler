defmodule Slamscheduler.ScheduleView do
  use Slamscheduler.Web, :view

  def render("index.json", %{schedule: schedule}) do
    schedule
  end
end

