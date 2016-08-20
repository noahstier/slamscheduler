import Html exposing (div, text, Html, h2)
import List exposing (map)
import Html.App as App

main =
  App.beginnerProgram
    { view = view
    , model = model
    , update = update
    }

type alias Model = List Day

type alias Day =
  { name : String
  , slots : List Slot
  }

type alias Slot =
  { skill : String
  , instructor : String
  }

type Msg = None

model : Model
model =
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

update : Msg -> Model -> Model
update msg model = model

slotView : Slot -> Html Msg
slotView slot =
  div [] [ text (slot.skill ++ " - " ++ slot.instructor) ]

dayView : Day -> Html Msg
dayView day =
  div []
    [ h2 [] [ text day.name ]
    , div [] (map slotView day.slots)
    ]

view : Model -> Html Msg
view model =
  div [] (map dayView model)

