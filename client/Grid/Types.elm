module Grid.Types exposing (..)

import Animation
import Dict exposing (Dict)


type alias Model =
    Dict Int Animation.State


type Msg
    = PickNumber Int
