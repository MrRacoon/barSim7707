module Cell.View exposing (..)

import Html exposing (Html, div, text)
import Cell.Types exposing (Model, Msg(..))
import Animation


view : Model -> Html Msg
view model =
    div (Animation.render model.style)
        [ text <| toString model.number ]
