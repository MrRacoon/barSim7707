module Grid.Types exposing (..)

import Animation
import Dict
import Cell.Types as Cell
import Status.Types as Status


type alias Model =
    { cells : Dict.Dict Int Cell.Model
    , ball : Animation.State
    , status : Status.Model
    , height : Int
    , width : Int
    }


type Msg
    = Pick Int
    | Reset
    | Resize Int Int
    | CellMsg Int Cell.Msg
    | BallMsg Animation.Msg
    | StatusMsg Status.Msg
