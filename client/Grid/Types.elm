module Grid.Types exposing (..)

import Array
import Animation
import Cell.Types as Cell


type alias Model =
    { cells : Array.Array Cell.Model
    , ball : Animation.State
    }


type Msg
    = Pick Int
    | Reset
    | CellMsg Int Cell.Msg
    | BallMsg Animation.Msg
