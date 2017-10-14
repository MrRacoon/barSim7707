module Grid.State exposing (..)

import Grid.Types exposing (Model, Msg(..))
import Array
import Animation
import Color exposing (blue, green)


initialStyles : List Animation.Property
initialStyles =
    [ Animation.fill blue ]


init : ( Model, Cmd Msg )
init =
    { cells = (Array.fromList (List.repeat 80 (Animation.style initialStyles)))
    , ball = Animation.style []
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate index aMsg ->
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

        Pick index ->
            case Array.get index model.cells of
                Nothing ->
                    model ! []

                Just elem ->
                    { model
                        | cells =
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
    model.cells
        |> Array.indexedMap (\i s -> Animation.subscription (Animate i) [ s ])
        |> Array.toList
        |> Sub.batch
