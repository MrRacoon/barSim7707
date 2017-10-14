module Grid.State exposing (..)

import Constants exposing (cells, rows, totalNumbers)
import Grid.Types exposing (Model, Msg(..))
import Cell.State as Cell
import Cell.Types as CellTypes
import Array


board : List CellTypes.Model
board =
    List.repeat totalNumbers (Cell.init)


init : ( Model, Cmd Msg )
init =
    (Array.fromList board)
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CellMsg index cmsg ->
            case Array.get index model of
                Nothing ->
                    model ! []

                Just elem ->
                    let
                        ( cellState, cellCmd ) =
                            Cell.update cmsg elem
                    in
                        Array.set index cellState model
                            ! [ Cmd.map (CellMsg index) cellCmd ]


subscriptions : Model -> Sub Msg
subscriptions model =
    model
        |> Array.indexedMap (\i s -> Sub.map (CellMsg i) <| Cell.subscriptions s)
        |> Array.toList
        |> Sub.batch
