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
    (Array.fromList (List.repeat 80 (Animation.style initialStyles)))
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate index aMsg ->
            case Array.get index model of
                Nothing ->
                    model ! []

                Just elem ->
                    Array.set index (Animation.update aMsg elem) model
                        ! []

        Reset ->
            (Array.map
                (Animation.interrupt
                    [ Animation.set
                        [ Animation.fill blue
                        ]
                    ]
                )
                model
            )
                ! []

        Pick index ->
            case Array.get index model of
                Nothing ->
                    model ! []

                Just elem ->
                    Array.set index
                        (Animation.interrupt
                            [ Animation.to
                                [ Animation.fill green
                                ]
                            ]
                            elem
                        )
                        model
                        ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    model
        |> Array.indexedMap (\i s -> Animation.subscription (Animate i) [ s ])
        |> Array.toList
        |> Sub.batch
