import Enum

defmodule Slamscheduler2.VolunteersController do
  use Slamscheduler2.Web, :controller

  @days ["Mo", "Tu", "We", "Th", "Fr"]
  @skills ["Guitar", "Piano", "Voice", "Percussion", "Rockband", "Songwriting"]

  def create(conn, params = %{"name" => name}) do
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
    redirect conn, to: "/"
  end

  def update(conn, params = %{"name" => name}) do
    IO.puts("----------")
    IO.inspect params
    IO.puts("----------")

    days = params
      |> Map.take(@days)
      |> Map.keys

    skills = params
      |> Map.take(@skills)
      |> Map.keys

    updated_volunteer = %{
      name: name,
      availability: days,
      skills: skills
    }

    saved_volunteers = get_session(conn, :volunteers)
    volunteers = saved_volunteers
      |> filter(fn vol -> ! vol.name == updated_volunteer.name end)
      |> concat([updated_volunteer])

    
    conn = put_session(conn, :volunteers, volunteers)

    redirect conn, to: "/"
  end

  def delete(conn, _params) do
    conn = put_session(conn, :volunteers, [])
    redirect conn, to: "/"
  end
end
