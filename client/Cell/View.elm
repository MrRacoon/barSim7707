module Cell.View exposing (..)

import Html exposing (Html, div, text)
import Utils exposing (location)
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


view : Int -> Int -> ( Int, Animation.State ) -> Svg msg
view sHeight sWidth ( number, styles ) =
    let
        loc =
            location sHeight sWidth number

        transformation =
            transform <| "translate(" ++ toString loc.x ++ "," ++ toString loc.y ++ ")"
    in
        g [ transformation ]
            [ rect
                (Animation.render styles
                    ++ [ width <| toString <| loc.width - 3
                       , height <| toString <| loc.height - 3
                       ]
                )
                []
            , text_
                [ fill "black"
                , y <| toString <| loc.height / 1.5
                , x <| toString <| loc.width / 3
                , fontSize <| toString 40
                ]
                [ text <| toString <| loc.col + (loc.row * 10) ]
            ]
