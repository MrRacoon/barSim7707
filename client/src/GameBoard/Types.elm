module GameBoard.Types exposing (..)

import Set exposing (Set)

type alias Model =
  { available : List String
  , selected : Set String
  }

type Msg
  = SelectNumber String
  | ClearSelected
