module Grid.Types exposing (..)

import Cell.Types as Cell
import Array


type alias Model =
    Array.Array Cell.Model


type Msg
    = CellMsg Int Cell.Msg
