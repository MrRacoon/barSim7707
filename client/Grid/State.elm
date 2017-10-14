module Grid.State exposing (..)

import Constants exposing (cells, rows, totalNumbers)
import Grid.Types exposing (Model, Msg, Number(..))
import Color exposing (green)
import Animation


board : List Number
board =
    let
        initStyles =
            Animation.style
                [ Animation.fill green
                ]

        makeNum n =
            Number (toFloat n) initStyles
    in
        List.map makeNum (List.range 1 (totalNumbers))


init : ( Model, Cmd Msg )
init =
    { numbers = board
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
