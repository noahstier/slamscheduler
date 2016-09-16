import Enum
import Map
import NoahsLittleHelpers

defmodule Schedule do

  def possible_slots(volunteer) do
    for skill <- volunteer.skills, day <- volunteer.availability do
      %{skill: skill, day: day}
    end
  end
  
  def class_offered?(slot, slots) do
    slots
    |> filter(fn s -> s == slot end) # merge because slot also has :name
    |> Enum.count > 0
  end

  def taken?(slot), do: Map.get(slot, :name) != nil

  def schedules([], open_slots, taken_slots), do: taken_slots

  def schedules(volunteers, [], taken_slots), do: taken_slots

  def schedules([first_volunteer | other_volunteers], open_slots, taken_slots) do
    first_volunteer
    |> possible_slots
    |> filter(fn slot -> Enum.member?(open_slots, slot) end)
    |> map(fn slot -> schedules(
      other_volunteers, 
      drop_one(open_slots, slot),
      taken_slots ++ [Map.merge(slot, %{name: first_volunteer.name})]
    ) end)
    |> flatten_2
  end

end
