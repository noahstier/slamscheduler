defmodule Slamscheduler.ScheduleController do
  use Slamscheduler.Web, :controller

  def generate(conn, _params) do
    render conn, "index.json", schedule: %{
      monday: %{
        guitar: [
          "Noah Stier"
        ]
      },
      tuesday: %{
        voice: [
          "Zeke Wald"
        ]
      },
      wednesday: %{
      },
      thursday: %{
      },
      friday: %{
      }
    }
  end
end
