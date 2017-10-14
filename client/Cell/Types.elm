module Cell.Types exposing (..)

import Animation


type alias Model =
    Animation.State


type Msg
    = Reset
    | Animate Animation.Msg
    | Pick
