module Grid.View exposing (..)

import Grid.Types exposing (Model, Msg(..))
import Cell.View as Cell
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
            ++ [ g [ transform "translate(0,0)" ]
                    [ circle (Animation.render model.ball) [] ]
               ]
        )
