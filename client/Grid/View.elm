module Grid.View exposing (..)

import Grid.Types exposing (Model, Msg(..))
import Cell.View as Cell
import Dict
import Animation
import Svg exposing (Svg, svg, rect, circle, g)


view : Model -> Svg Msg
view model =
    g []
        ((List.map Cell.view (Dict.values model.cells))
            ++ [ circle (Animation.render model.ball) [] ]
        )
