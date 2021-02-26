module Status.Types exposing (..)

import Animation


type alias Model =
    { isShown : Bool
    , g : Animation.State
    , rect : Animation.State
    , text : Animation.State
    , message : String
    , timer : Animation.State
    }


type Msg
    = Show Bool
    | UpdateMessage String
    | UpdateG Animation.Msg
    | UpdateRect Animation.Msg
    | UpdateText Animation.Msg
    | UpdateTimer Animation.Msg
