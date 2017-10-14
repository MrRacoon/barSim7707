module Grid.Types exposing (..)

import Array
import Animation


type alias Model =
    { cells : Array.Array Animation.State
    , ball : Animation.State
    }


type Msg
    = Reset
    | Animate Int Animation.Msg
    | Pick Int
