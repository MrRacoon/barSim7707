module Grid.State exposing (..)

import Cell.State as Cell
import Cell.Types as CellTypes
import Grid.Types exposing (Model, Msg(..))
import Dict
import Animation
import Utils exposing (location)
import Color exposing (black, blue, red, yellow)
import Constants exposing (rows, cols)
import List.Extra as ListE


init : ( Model, Cmd Msg )
init =
    let
        newCells =
            List.map (\i -> ( i, Cell.init i )) <| List.range 1 (rows * cols)

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
            let
                newCells =
                    model.cells
                        |> Dict.toList
                        |> List.map
                            (\( i, c ) ->
                                ( i
                                , Cell.update (CellTypes.Reset <| location model.height model.width i) c
                                )
                            )

                cellState =
                    newCells
                        |> List.map (\( i, c ) -> ( i, Tuple.first c ))

                cellCmd =
                    newCells
                        |> List.map (\( i, c ) -> Cmd.map (CellMsg i) (Tuple.second c))
            in
                { model | cells = Dict.fromList cellState }
                    ! cellCmd

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
                { model
                    | height = h
                    , width = w
                    , cells = Dict.fromList cellState
                }
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

        Pick index ->
            case Maybe.map (Cell.update CellTypes.Picked) <| Dict.get index model.cells of
                Nothing ->
                    model ! []

                Just ( cellState, cellCmd ) ->
                    let
                        loc =
                            location model.height model.width index
                    in
                        { model
                            | cells = Dict.insert index cellState model.cells
                            , ball =
                                Animation.interrupt
                                    [ Animation.set
                                        [ Animation.cx (toFloat model.width / 2)
                                        , Animation.cy -1000
                                        , Animation.radius 1000
                                        , Animation.opacity 1
                                        , Animation.fill red
                                        ]
                                    , Animation.to
                                        [ Animation.cx (loc.x + (loc.width / 2))
                                        , Animation.cy (loc.y + (loc.height / 2))
                                        , Animation.radius 50
                                        , Animation.opacity 0.8
                                        , Animation.fill yellow
                                        ]
                                    , Animation.to
                                        [ Animation.opacity 0
                                        ]
                                    ]
                                    model.ball
                        }
                            ! [ Cmd.map (CellMsg index) cellCmd ]

        Summary picked ->
            let
                newCells =
                    model.cells
                        |> Dict.toList
                        |> List.map
                            (\( i, c ) ->
                                ( i
                                , case ListE.elemIndex i picked of
                                    Nothing ->
                                        Cell.update CellTypes.Hide c

                                    Just index ->
                                        let
                                            loc =
                                                location model.height model.width (index + 21)
                                        in
                                            Cell.update (CellTypes.MoveTo loc) c
                                )
                            )

                cellState =
                    newCells
                        |> List.map (\( i, c ) -> ( i, Tuple.first c ))
                        |> Dict.fromList

                cellCmd =
                    newCells
                        |> List.map (\( i, c ) -> Cmd.map (CellMsg i) (Tuple.second c))
            in
                { model | cells = cellState }
                    ! cellCmd


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
