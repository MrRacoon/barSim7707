module Grid.Types exposing (..)

import Animation
import Dict
import Cell.Types as Cell
import Utils exposing (Location)


type alias Model =
    { cells : Dict.Dict Int Cell.Model
    , ball : Animation.State
    , height : Int
    , width : Int
    }


type Msg
    = Pick Int
    | Reset
    | Resize Int Int
    | CellMsg Int Cell.Msg
    | BallMsg Animation.Msg
    | Summary (List Int)
