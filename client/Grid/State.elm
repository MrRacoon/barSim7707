module Grid.State exposing (..)

import Cell.State as Cell
import Cell.Types as CellTypes
import Grid.Types exposing (Model, Msg(..))
import Dict
import Animation
import Color exposing (blue, green, red, yellow)


init : ( Model, Cmd Msg )
init =
    let
        newCells =
            List.map (\i -> ( i, Cell.init i )) <| List.range 1 20

        cellState =
            newCells |> List.map (\( i, c ) -> ( i, Tuple.first c ))

        cellCmd =
            newCells
                |> List.map (\( i, c ) -> Cmd.map (CellMsg i) (Tuple.second c))
    in
        { cells = Dict.fromList cellState
        , ball =
            Animation.style
                [ Animation.fill yellow
                , Animation.cx -10
                , Animation.cy -10
                , Animation.radius 10
                ]
        , height = 300
        , width = 300
        }
            ! cellCmd


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Reset ->
            model
                ! []

        Resize h w ->
            let
                newCells =
                    model.cells
                        |> Dict.toList
                        |> List.map (\( i, c ) -> ( i, Cell.update (CellTypes.UpdateScreenSize h w) c ))

                cellState =
                    newCells
                        |> List.map (\( i, c ) -> ( i, Tuple.first c ))

                cellCmd =
                    newCells
                        |> List.map (\( i, c ) -> Cmd.map (CellMsg i) (Tuple.second c))
            in
                { model | height = h, width = w, cells = Dict.fromList cellState }
                    ! cellCmd

        BallMsg aMsg ->
            { model | ball = Animation.update aMsg model.ball }
                ! []

        CellMsg index cellMsg ->
            case Maybe.map (Cell.update cellMsg) <| Dict.get index model.cells of
                Nothing ->
                    model ! []

                Just ( cellState, cellCmd ) ->
                    { model | cells = Dict.insert index cellState model.cells }
                        ! [ Cmd.map (CellMsg index) cellCmd ]

        _ ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        ballAnimations =
            Animation.subscription BallMsg [ model.ball ]

        boxAnimations =
            model.cells
                |> Dict.toList
                |> List.map (\( i, s ) -> Sub.map (CellMsg i) <| Cell.subscriptions s)
    in
        Sub.batch <| [ ballAnimations ] ++ boxAnimations
