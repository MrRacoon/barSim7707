module GameBoard.Types exposing (..)

import Set exposing (Set)

type alias Model =
  { available : List String
  , selected : Set String
  , picked : String
  }

type Msg
  = SelectNumber String
  | ClearSelected
  | PickNumber String
