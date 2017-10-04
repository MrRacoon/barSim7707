module View exposing (..)

import Types exposing (Model, Msg)
import Html exposing (Html, div)
import Component.Grid as Grid
import Grid.View as Grid2


view : Model -> Html Msg
view model =
    div [] [ Grid2.view model ]
