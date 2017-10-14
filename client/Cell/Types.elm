module Cell.Types exposing (..)

import Animation


type alias Model =
    { number : Float
    , style : Animation.State
    }


type Msg
    = Reset
    | Animate Animation.Msg
    | Pick
