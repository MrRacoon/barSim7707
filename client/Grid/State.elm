module Grid.State exposing (..)

import Constants exposing (cells, rows, totalNumbers)
import Grid.Types exposing (Model, Msg, Number(..))


board : List Number
board =
    let
        makeNum n =
            Number n []
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
