import Enum
import Map
import Schedule

defmodule Slamscheduler2.ScheduleController do
  use Slamscheduler2.Web, :controller

  @days ["Mo", "Tu", "We", "Th", "Fr"]
  @skills ["Guitar", "Piano", "Voice", "Percussion", "Rockband", "Songwriting"]

  @classes [%{
    skill: "Guitar",
    day: "Mo"
  }, %{
    skill: "Piano",
    day: "Tu"
  }]

  def index(conn, params = %{"name" => name}) do
    days = params
      |> Map.take(@days)
      |> Map.keys

    skills = params
      |> Map.take(@skills)
      |> Map.keys

    new_volunteer = %{
      name: name,
      availability: days,
      skills: skills
    }
    saved_volunteers = get_session(conn, :volunteers)
    volunteers = saved_volunteers ++ [new_volunteer]
    conn = put_session(conn, :volunteers, volunteers)
    index(conn, %{volunteers: volunteers})
  end

  def index(conn, %{volunteers: volunteers}) do
    schedule = generate(volunteers, @classes)
    render conn, "index.html", %{
      schedule: schedule,
      volunteers: volunteers,
      days: @days,
      skills: @skills
    }
  end

  def index(conn, _params) do
    volunteers = 
      case get_session(conn, :volunteers) do
        [h | t] ->
          [h | t]
        _ ->
          []
      end

    index(conn, %{volunteers: volunteers})
  end
end
