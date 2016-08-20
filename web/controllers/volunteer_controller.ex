defmodule Slamscheduler.VolunteerController do
  use Slamscheduler.Web, :controller

  def index(conn, _params) do
    render conn, "index.json", volunteers: [
      %{
        name: "Noah Stier",
        score: 5,
        availability: %{
          monday: true,
          tuesday: false,
          wednesday: true,
          thursday: false,
          friday: false
        },
        classes: %{
          guitar: true,
          rockband: true,
          voice: false,
          piano: false
        }
      },
      %{
        name: "Zeke Wald",
        score: 1,
        availability: %{
          monday: false,
          tuesday: true,
          wednesday: true,
          thursday: false,
          friday: false
        },
        classes: %{
          guitar: false,
          rockband: false,
          voice: true,
          piano: true
        }
      }
    ]
  end

end
