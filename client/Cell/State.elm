module Cell.State exposing (..)

import Cell.Types exposing (Model, Msg(..))
import Animation
import Color exposing (blue, green)


initialStyles : List Animation.Property
initialStyles =
    [ Animation.fill blue ]


init : Model
init =
    Animation.style initialStyles


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Pick ->
            Animation.interrupt
                [ Animation.to
                    [ Animation.fill green ]
                ]
                model
                ! []

        Reset ->
            Animation.interrupt [ Animation.to initialStyles ] model
                ! []

        Animate amsg ->
            Animation.update amsg model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model ]
