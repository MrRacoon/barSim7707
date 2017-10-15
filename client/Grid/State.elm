module Grid.State exposing (..)

import Cell.State as Cell
import Cell.Types as CellMsg
import Grid.Types exposing (Model, Msg(..))
import Array
import Animation
import Color exposing (blue, green, red, yellow)


init : ( Model, Cmd Msg )
init =
    { cells = Array.fromList <| List.map Cell.init <| List.range 1 80
    , ball =
        Animation.style
            [ Animation.fill yellow
            , Animation.cx -10
            , Animation.cy -10
            , Animation.radius 10
            ]
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Reset ->
            model ! []

        BallMsg aMsg ->
            { model | ball = Animation.update aMsg model.ball } ! []

        CellMsg index aMsg ->
            case Array.get index model.cells of
                Nothing ->
                    model ! []

                Just elem ->
                    { model | cells = Array.set index (Cell.update aMsg elem) model.cells }
                        ! []

        Pick index ->
            case Array.get index model.cells of
                Nothing ->
                    model ! []

                Just elem ->
                    { model
                        | cells =
                            Array.set
                                index
                                (Cell.update (CellMsg.UpdateColor blue) elem)
                                model.cells
                    }
                        ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        ballAnimations =
            Animation.subscription BallMsg [ model.ball ]

        -- boxAnimations =
        --     model.cells
        --         |> Array.indexedMap (\i s -> Animation.subscription (CellMsg i) [ s ])
        --         |> Array.toList
    in
        Sub.batch <| [ ballAnimations ]
