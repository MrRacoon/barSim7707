module Cell.State exposing (..)

import Cell.Types exposing (Model, Msg(..))
import Animation
import Color exposing (blue)


initialStyles : List Animation.Property
initialStyles =
    [ Animation.fill blue ]


init : Float -> ( Model, Cmd Msg )
init n =
    { number = n
    , style = Animation.style initialStyles
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Pick ->
            { model | style = Animation.interrupt [] model.style } ! []

        Reset ->
            { model
                | style = Animation.interrupt [ Animation.to initialStyles ] model.style
            }
                ! []

        Animate amsg ->
            { model | style = Animation.update amsg model.style } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model.style ]
