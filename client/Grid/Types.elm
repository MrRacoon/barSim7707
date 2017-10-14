module Grid.Types exposing (..)

import Array
import Animation


type alias Model =
    Array.Array Animation.State


type Msg
    = Reset
    | Animate Int Animation.Msg
    | Pick Int
