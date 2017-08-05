module GameBoard.State exposing (..)

import GameBoard.Types exposing (..)
import Constants as C

import List exposing (map, range)
import Set as Set

init : Model
init = Model
  (map toString <| range 1 C.boardCount)
  Set.empty
  ""

update : Msg -> Model -> Model
update msg model = case msg of
  SelectNumber num -> { model | selected = Set.insert num model.selected }
  ClearSelected    -> { model | selected = Set.empty }
  PickNumber num   -> { model | picked = num }
