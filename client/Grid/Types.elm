module Grid.Types exposing (..)

import Animation


type alias Model =
    { numbers : List Number }


type Msg
    = FadeToColor String


type Number
    = Number Float Animation.State
