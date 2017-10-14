module Grid.State exposing (..)

import Grid.Types exposing (Model, Msg(..))
import Array
import Animation
import Utils exposing (location)
import Color exposing (blue, green, red, yellow)


initialStyles : List Animation.Property
initialStyles =
    [ Animation.fill blue ]


init : ( Model, Cmd Msg )
init =
    { cells = (Array.fromList (List.repeat 80 (Animation.style initialStyles)))
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
        AnimateBall aMsg ->
            { model | ball = Animation.update aMsg model.ball } ! []

        AnimateCell index aMsg ->
            case Array.get index model.cells of
                Nothing ->
                    model ! []

                Just elem ->
                    { model
                        | cells = Array.set index (Animation.update aMsg elem) model.cells
                    }
                        ! []

        Reset ->
            { model
                | cells =
                    (Array.map
                        (Animation.interrupt
                            [ Animation.set
                                [ Animation.fill blue
                                ]
                            ]
                        )
                        model.cells
                    )
            }
                ! []

        Pick h w index ->
            case Array.get index model.cells of
                Nothing ->
                    model ! []

                Just elem ->
                    let
                        loc =
                            location h w index
                    in
                        { model
                            | ball =
                                (Animation.interrupt
                                    [ Animation.set
                                        [ Animation.fill red
                                        , Animation.radius 200
                                        , Animation.cx (toFloat w / 2)
                                        , Animation.cy -100
                                        , Animation.opacity 1
                                        ]
                                    , Animation.to
                                        [ Animation.fill yellow
                                        , Animation.radius 50
                                        , Animation.cx (loc.x + (loc.width / 2))
                                        , Animation.cy (loc.y + (loc.height / 2))
                                        ]
                                    , Animation.set
                                        [ Animation.opacity 0
                                        ]
                                    ]
                                    model.ball
                                )
                            , cells =
                                Array.set index
                                    (Animation.interrupt
                                        [ Animation.to
                                            [ Animation.fill green
                                            ]
                                        ]
                                        elem
                                    )
                                    model.cells
                        }
                            ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        ballAnimations =
            Animation.subscription AnimateBall [ model.ball ]

        boxAnimations =
            model.cells
                |> Array.indexedMap (\i s -> Animation.subscription (AnimateCell i) [ s ])
                |> Array.toList
    in
        Sub.batch <| boxAnimations ++ [ ballAnimations ]
