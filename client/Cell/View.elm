module Cell.View exposing (..)

import Html exposing (Html, div, text)
import Cell.Types exposing (Model, Msg(..))
import Constants exposing (padding)
import Utils exposing (numberCoordinates)
import Svg exposing (Svg, g, rect, text_)
import Animation
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


view : Int -> Int -> ( Int, Model ) -> Svg msg
view sHeight sWidth ( number, styles ) =
    let
        ( xp, yp ) =
            numberCoordinates number

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
