module Stats.Types exposing (..)

import Animation
import Dict exposing (Dict)


type alias Model =
    { isShown : Bool
    , g : Animation.State
    , history : Dict Int Int
    , last : List (List Int)
    }


type Msg
    = Show (List Int)
    | Hide
    | UpdateG Animation.Msg
