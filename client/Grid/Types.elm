module Grid.Types exposing (..)

import Animation as Anim


type alias Model =
    { numbers : List Number }


type Msg
    = FadeToColor String


type Number
    = Number Int Styles


type alias Styles =
    List Anim.State
