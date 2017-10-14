module Grid.Types exposing (..)

import Array
import Animation


type alias Model =
    { cells : Array.Array Animation.State
    , ball : Animation.State
    }


type Msg
    = Reset
    | AnimateCell Int Animation.Msg
    | AnimateBall Animation.Msg
    | Pick Int
