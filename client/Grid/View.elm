module Grid.View exposing (..)

import Grid.Types exposing (Model, Msg(..))
import Cell.View as Cell
import Array
import Animation
import Svg exposing (Svg, svg, rect)
import Svg.Attributes exposing (height, width, fill)


view : Int -> Int -> Model -> Svg Msg
view sHeight sWidth model =
    svg
        [ height <| toString sHeight
        , width <| toString sWidth
        ]
        ([ rect
            [ height <| toString sHeight
            , width <| toString sWidth
            , fill "grey"
            ]
            []
         ]
            ++ (List.map (makeCell sHeight sWidth) (Array.toIndexedList model))
        )


makeCell : Int -> Int -> ( Int, Animation.State ) -> Svg Msg
makeCell h w ( i, s ) =
    (Cell.view h w ( i, s ))
