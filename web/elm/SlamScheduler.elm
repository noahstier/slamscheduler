module SlamScheduler exposing (..)

import Html exposing (div, text, Html, h2, p, ul, li, button)
import Html.Attributes exposing (contenteditable)
import Html.Events exposing (onClick)
import List exposing (map, filter)
import Html.App as App

main =
  App.beginnerProgram
    { view = view
    , model = model
    , update = update
    }

type alias Model =
  { schedule : List Day
  , volunteers : List Volunteer
  }

type alias Day =
  { name : String
  , slots : List Slot
  }

type alias Slot =
  { skill : String
  , instructor : String
  }

type alias Volunteer =
  { name : String
  , skills : List String
  , availability: List String
  }

type Action 
  = Remove String String

model : Model
model =
  { schedule =
    [ { name = "Monday"
      , slots =
          [ { skill = "guitar", instructor = "Noah" }
          ]
      }
    , { name = "Tuesday"
      , slots =
          [ { skill = "slacklining", instructor = "James" }
          ]
      }
    , { name = "Wednesday"
      , slots =
          [ { skill = "guitar", instructor = "Noah" }
          , { skill = "slacklining", instructor = "James" }
          ]
      }
    , { name = "Thursday"
      , slots =
        [ { skill = "slacklining", instructor = "James" }
        ]
      }
    , { name = "Friday"
      , slots =
        [ { skill = "guitar", instructor = "Noah" }
        ]
      }
    ]
  , volunteers =
    [ { name = "James Vaughan"
      , skills = [ "slacklining" ]
      , availability = [ "tuesday", "wednesday", "thursday" ]
      }
    , { name = "Noah Stier"
      , skills = ["guitar"]
      , availability = ["monday", "wednesday", "friday"]
      }
    ]
  }

update : Action -> Model -> Model
update action model = 
  case action of
    Remove name day ->
      { model | volunteers = 
        model.volunteers
        |> map ( \v -> 
          if v.name == name then
            { v | availability = filter ( \d -> d /= day ) v.availability }
          else
            v
          )
      }

slotView : Slot -> Html Action
slotView slot =
  div [] [ text (slot.skill ++ " - " ++ slot.instructor) ]

dayView : Day -> Html Action
dayView day =
  div []
    [ h2 [] [ text day.name ]
    , div [] (map slotView day.slots)
    ]

removeButton : String -> String -> Html Action
removeButton name day =
  button [ onClick (Remove name day) ] [ text "X" ]

editableList : List String -> String -> Html Action
editableList list name =
  ul []
    (map (\str -> li [contenteditable True] [ text str, removeButton name str ]) list)

volunteerView : Volunteer -> Html Action
volunteerView volunteer =
  div []
    [ p [] [ text volunteer.name ]
    , editableList volunteer.skills volunteer.name
    , editableList volunteer.availability volunteer.name
    ]

view : Model -> Html Action
view model =
  div []
    [ div [] (map dayView model.schedule)
    , div [] (map volunteerView model.volunteers)
    ]

