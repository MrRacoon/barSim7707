module View exposing (..)

import Types exposing (Model, Msg)
import Html exposing (Html, div)
import Grid.View as Grid


view : Model -> Html Msg
view model =
    div [] [ Grid.view model ]
