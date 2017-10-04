module View exposing (..)

import Types exposing (Model, Msg)
import Html exposing (Html, div)
import Component.Grid as Grid


view : Model -> Html Msg
view model =
    div [] [ Grid.render model ]
