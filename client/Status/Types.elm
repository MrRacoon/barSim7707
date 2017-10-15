module Status.Types exposing (..)

import Animation


type alias Model =
    { time : Float
    , isShown : Bool
    , g : Animation.State
    , rect : Animation.State
    , text : Animation.State
    }


type Msg
    = Show Bool
    | UpdateTimer Float
    | UpdateG Animation.Msg
    | UpdateRect Animation.Msg
    | UpdateText Animation.Msg
