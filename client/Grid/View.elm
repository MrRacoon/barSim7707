module Grid.View exposing (..)

import Grid.Types exposing (Model)
import Grid.Utils exposing (numberCoordinates)
import Constants exposing (board, padding)
import Animation
import Dict as Dict
import Svg exposing (Svg, svg, g, rect, text_, text)
import Svg.Attributes
    exposing
        ( height
        , width
        , x
        , dx
        , y
        , dy
        , fill
        , transform
        , fontSize
        )


view : Int -> Int -> Model -> Svg msg
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
            ++ (List.map (drawCell sHeight sWidth) (Dict.toList model))
        )


drawCell : Int -> Int -> ( Int, Animation.State ) -> Svg msg
drawCell sHeight sWidth ( num, styles ) =
    let
        ( xp, yp ) =
            numberCoordinates num

        usableXSpace =
            sWidth - (round <| padding * 12)

        usableYSpace =
            sHeight - (round <| padding * 10)

        boxWidth =
            toFloat usableXSpace / 10

        boxHeight =
            toFloat usableYSpace / 8

        xVal =
            (xp * (boxWidth + padding)) - boxWidth

        yVal =
            yp * (boxHeight + padding)

        transformation =
            transform <| "translate(" ++ toString xVal ++ "," ++ toString yVal ++ ")"
    in
        g [ transformation ]
            [ rect
                (Animation.render styles
                    ++ [ width <| toString <| boxWidth - 3
                       , height <| toString <| boxHeight - 3
                       ]
                )
                []
            , text_
                [ fill "black"
                , y <| toString <| boxHeight / 1.5
                , x <| toString <| boxWidth / 3
                , fontSize <| toString 40
                ]
                [ text <| toString <| xp + (yp * 10) ]
            ]
