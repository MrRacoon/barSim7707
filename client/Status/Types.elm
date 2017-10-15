module Status.Types exposing (..)

import Animation


type alias Model =
    { time : Float
    , isShown : Bool
    , message : String
    , g : Animation.State
    , rect : Animation.State
    , text : Animation.State
    }


type Msg
    = Show Bool
    | UpdateTimer Float
    | UpdateMessage String
    | UpdateG Animation.Msg
    | UpdateRect Animation.Msg
    | UpdateText Animation.Msg
