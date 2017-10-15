module Cell.View exposing (..)

import Cell.Types exposing (Model)
import Html exposing (Html, div, text)
import Svg exposing (Svg, g, rect, text_)
import Animation


view : Model -> Svg msg
view cell =
    g (Animation.render cell.g)
        [ rect (Animation.render cell.rect) []
        , text_ (Animation.render cell.text) [ text <| toString cell.num ]
        ]
