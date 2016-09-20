import Enum
import Map

defmodule Schedule do

  @days ["Mo", "Tu", "We", "Th", "Fr"]
  @skills ["Guitar", "Piano", "Voice", "Percussion", "Rockband", "Songwriting"]


  def possible_slots(volunteer) do
    volunteer.availability
    |> flat_map(fn day ->
      volunteer.skills
      |> map(fn skill ->
        %{skill: skill, day: day}
      end)
    end)
  end

  def create_graph(volunteers, classes) do
    graph = :graph.empty(:directed, :d)  # d for integer weights
    :graph.add_vertex(graph, "source")
    :graph.add_vertex(graph, "sink")
    each(classes, fn class ->
      :graph.add_vertex(graph, class)
      :graph.add_edge(graph, class, "sink", 2)
    end)
    each(volunteers, fn vol ->
      :graph.add_vertex(graph, vol)
      :graph.add_edge(graph, "source", vol, 1)
      each(possible_slots(vol), fn slot ->
        :graph.add_edge(graph, vol, slot, 1)
      end)
    end)
    graph
  end

  def generate(volunteers, classes) do
    graph = create_graph(volunteers, classes)
    {flow, edges} = :edmonds_karp.run(graph, "source", "sink", :dfs)

    blank_schedule = classes
      |> reduce(%{}, fn class, sched ->
        if has_key?(sched, class.day) do
          if has_key?(sched[class.day], class.skill) do
            sched
          else
            put_in(sched, [class.day, class.skill], [])
          end
        else
          put(sched, class.day, %{class.skill => []})
        end
      end)

    slots =
      for {{%{name: name}, %{day: day, skill: skill}}, flow} <- edges do
        %{name: name, day: day, skill: skill}
      end

    schedule = slots
      |> reduce(blank_schedule, fn slot, sched ->
        update_in(sched, [slot.day, slot.skill], fn class -> 
         class ++ [slot.name]
        end)
      end)
      
    schedule
  end

end
