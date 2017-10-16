module Status.View exposing (..)

import Svg exposing (Svg, g, rect, text_, text)
import Status.Types exposing (Model)
import Animation


view : Model -> Int -> Int -> Svg msg
view model mins secs =
    let
        time =
            toString mins ++ ":" ++ toString secs
    in
        g (Animation.render model.g)
            [ rect (Animation.render model.rect) []
            , text_ (Animation.render model.text) [ text model.message ]
            , text_ (Animation.render model.timer) [ text time ]
            ]
