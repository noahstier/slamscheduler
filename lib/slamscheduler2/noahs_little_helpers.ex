defmodule NoahsLittleHelpers do

  # flatten nested lists to a maximum depth of 2
  def flatten_2(nested_lists) do
    case nested_lists do
      [[%{} | _] | _] -> # list of list of maps
        nested_lists
      [[[_ | _] | _] | _] -> # list of list of lists
        Enum.concat(nested_lists)
    end
  end

  def drop_at(enum, ind) do
    if ind > Enum.count(enum) - 1 do
      enum
    else
      Enum.concat([
        Enum.slice(enum, 0, ind),
        Enum.slice(enum, ind + 1, Enum.count(enum) - ind)
      ])
    end
  end

  def drop_one(enum, val) do
    ind = Enum.find_index(enum, fn el -> el == val end)
    drop_at(enum, ind)
  end

end
