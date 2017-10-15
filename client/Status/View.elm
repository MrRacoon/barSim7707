module Status.View exposing (..)

import Svg exposing (Svg, g, rect, text_, text)
import Animation


view : Animation.State -> Svg msg
view styles =
    rect (Animation.render styles) []
