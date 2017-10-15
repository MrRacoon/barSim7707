module Grid.View exposing (..)

import Grid.Types exposing (Model, Msg(..))
import Cell.View as Cell
import Status.View as Status
import Dict
import Animation
import Svg exposing (Svg, svg, rect, circle, g)
import Svg.Attributes exposing (height, width, fill, transform, cx, cy, r)


view : Model -> Svg Msg
view model =
    svg [ height <| toString model.height, width <| toString model.width ]
        ([ rect
            [ height <| toString model.height
            , width <| toString model.width
            , fill "grey"
            ]
            []
         ]
            ++ (List.map Cell.view (Dict.values model.cells))
            ++ [ circle (Animation.render model.ball) [] ]
            ++ [ Status.view model.status ]
        )
