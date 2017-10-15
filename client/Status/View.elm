module Status.View exposing (..)

import Svg exposing (Svg, g, rect, text_, text)
import Status.Types exposing (Model, Msg(..))
import Animation


view : Model -> Svg msg
view model =
    g (Animation.render model.g)
        [ rect (Animation.render model.rect) []
        , text_ (Animation.render model.text) []
        ]
