defmodule Slamscheduler.ScheduleController do
  use Slamscheduler.Web, :controller

  def generate(conn, _params) do

    volunteers = [
      %{
        name: "Noah Stier",
        availability: [:monday, :wednesday],
        skills: [:guitar, :rockband]
      },
      %{
        name: "James Vaughan",
        availability: [:monday, :wednesday],
        skills: [:voice, :piano]
      },
      %{
        name: "Zeke Wald",
        availability: [:monday, :thursday],
        skills: [:voice, :piano]
      }
    ]

    classes = [
      %{skill: :guitar, day: :monday},
      %{skill: :piano, day: :monday},
      %{skill: :voice, day: :monday},
      %{skill: :rockband, day: :monday},
      %{skill: :guitar, day: :wednesday},
      %{skill: :piano, day: :wednesday},
      %{skill: :voice, day: :wednesday},
      %{skill: :rockband, day: :wednesday},
      %{skill: :guitar, day: :thursday},
      %{skill: :piano, day: :thursday},
      %{skill: :voice, day: :thursday},
      %{skill: :rockband, day: :thursday}
    ]

    graph = :graph.empty(:directed)
    :graph.add_vertex(graph, "source")
    :graph.add_vertex(graph, "sink")
    Enum.each(classes, fn class -> 
      :graph.add_vertex(graph, class)
      :graph.add_edge(graph, class, "sink", 2)
    end)
    Enum.each(volunteers, fn %{name: name, skills: skills, availability: availability} -> 
      :graph.add_vertex(graph, name) 
      :graph.add_edge(graph, "source", name, 1)
      Enum.each(skills, fn skill ->
        Enum.each(availability, fn day ->
          :graph.add_edge(graph, name, %{skill: skill, day: day}, 1)
        end)
      end)
    end)

    maxflow = :edmonds_karp.run(graph, "source", "sink", :dfs)
    
    schedule = Enum.filter(elem(maxflow, 1), fn e -> elem(e, 1) != 0 end) # edges that have flow
    |> Enum.filter(fn {{edge1, edge2}, weight} -> # second vertex is a map i.e. a class
     case edge2 do
       %{} ->
         true
       _ ->
         false
		 end
		end)
    |> Enum.map(fn {{name, %{skill: skill, day: day}}, weight} ->
      %{name: name, skill: skill, day: day}
    end)

    json conn, schedule
  end
end
