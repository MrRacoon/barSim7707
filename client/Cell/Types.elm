module Cell.Types exposing (..)

import Animation
import Color exposing (Color)
import Utils exposing (Location)


type alias Model =
    { num : Int
    , g : Animation.State
    , rect : Animation.State
    , text : Animation.State
    }


type Msg
    = UpdateG Animation.Msg
    | UpdateRect Animation.Msg
    | UpdateText Animation.Msg
    | UpdatePosition Float Float
    | UpdateScreenSize Int Int
    | UpdateColor Color
    | Picked
    | Reset Location
    | MoveTo Location
    | Hide
