module Cell.Types exposing (..)

import Animation
import Utils exposing (Location)


type alias Model =
    { num : Int
    , loc : Location
    , g : Animation.State
    , rect : Animation.State
    , text : Animation.State
    }


type Msg
    = UpdateG Animation.Msg
    | UpdateRect Animation.Msg
    | UpdateText Animation.Msg
    | UpdateScreenSize Int Int
    | Picked
    | Reset Location
    | MoveTo Location
    | Hide
