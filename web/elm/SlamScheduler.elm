module SlamScheduler exposing (..)

import Html exposing (div, text, Html, h2, p, ul, li)
import List exposing (map)
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

type Action = None

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
update action model = model

slotView : Slot -> Html Action
slotView slot =
  div [] [ text (slot.skill ++ " - " ++ slot.instructor) ]

dayView : Day -> Html Action
dayView day =
  div []
    [ h2 [] [ text day.name ]
    , div [] (map slotView day.slots)
    ]

volunteerView : Volunteer -> Html Action
volunteerView volunteer =
  div []
    [ p [] [ text volunteer.name ] 
    , ul []
      (map (\skill -> li [] [ text skill ]) volunteer.skills)
    , ul []
      (map (\day -> li [] [ text day ]) volunteer.availability)
    ]

view : Model -> Html Action
view model =
  div [] 
    [ div [] (map dayView model.schedule)
    , div [] (map volunteerView model.volunteers)
    ]

