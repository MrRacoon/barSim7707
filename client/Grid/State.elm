module Grid.State exposing (..)

import Constants exposing (cells, rows, totalNumbers)
import Grid.Types exposing (Model, Msg(..))
import Grid.Utils exposing (pickNumber)
import Color exposing (green)
import Animation
import Dict as Dict


board : List ( Int, Animation.State )
board =
    let
        initStyles =
            Animation.style
                [ Animation.fill green
                ]

        makeNum n =
            ( n, initStyles )
    in
        List.map makeNum (List.range 1 (totalNumbers))


init : ( Model, Cmd Msg )
init =
    (Dict.fromList board)
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PickNumber num ->
            (Dict.map pickNumber model) ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
