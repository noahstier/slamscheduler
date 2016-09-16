import Enum
import Map
import Schedule
  
defmodule Slamscheduler2.ScheduleController do
  use Slamscheduler2.Web, :controller

  def index(conn, _params) do

    volunteers = [
      %{
        name: "Noah Stier",
        availability: [:Mo, :We],
        skills: [:Guitar, :Rockband]
      },
      %{
        name: "James Vaughan",
        availability: [:Mo, :We],
        skills: [:Voice, :Piano]
      },
      %{
        name: "Zeke Wald",
        availability: [:Mo, :Th],
        skills: [:Voice, :Piano]
      }
    ]
    
    classes = [
      %{skill: :Guitar, day: :Mo},
      %{skill: :Piano, day: :Mo},
      %{skill: :Voice, day: :Mo},
      %{skill: :Rockband, day: :Mo},
      %{skill: :Guitar, day: :We},
      %{skill: :Piano, day: :We},
      %{skill: :Voice, day: :We},
      %{skill: :Rockband, day: :We},
      %{skill: :Guitar, day: :Th},
      %{skill: :Piano, day: :Th},
      %{skill: :Voice, day: :Th},
      %{skill: :Rockband, day: :Th}
    ]

    scheds = schedules(volunteers, concat([classes, classes]), [])
      |> map(fn slots ->
        reduce(slots, %{}, fn slot, sched ->
          update(sched, slot.day, %{slot.skill => [slot.name]}, fn classes ->
            update(classes, slot.skill, [slot.name], fn class ->
              class ++ [slot.name]
            end)
          end)
        end)
      end)
      |> slice(0, 10)

    render conn, "index.html", schedules: scheds
  end
end
