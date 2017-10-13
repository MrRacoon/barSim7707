module Grid.View exposing (..)

import Types exposing (Model)
import Html exposing (Html)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, g, rect, text_, text)
import Svg.Attributes exposing (height, width, x, dx, y, dy, fill, transform)


padding : Float
padding =
    10


rows : Int
rows =
    8


cells : Int
cells =
    10


board : List ( Float, Float )
board =
    let
        makeCell yVal xVal =
            ( toFloat xVal, toFloat yVal )

        makeRow index =
            List.map (makeCell index) (List.range 1 cells)
    in
        List.concatMap makeRow (List.range 0 (rows - 1))


view : Model -> Html msg
view model =
    svg
        [ height <| toString model.screenHeight
        , width <| toString model.screenWidth
        ]
        (List.map (drawCell model) board)


drawCell : Model -> ( Float, Float ) -> Svg msg
drawCell model ( xp, yp ) =
    let
        usableXSpace =
            model.screenWidth - (padding * 12)

        usableYSpace =
            model.screenHeight - (padding * 10)

        boxWidth =
            (usableXSpace / 10)

        boxHeight =
            usableYSpace / 8

        xVal =
            (xp * (boxWidth + padding)) - boxWidth

        yVal =
            yp * (boxHeight + padding)

        transformation =
            transform <| "translate(" ++ toString xVal ++ "," ++ toString yVal ++ ")"

        styles =
            []
    in
        g [ transformation ]
            [ rect
                [ fill "black"
                , width <| toString boxWidth
                , height <| toString boxHeight
                ]
                []
            , rect
                [ style styles
                , width <| toString <| boxWidth - 3
                , height <| toString <| boxHeight - 3
                , fill "blue"
                ]
                []
            , text_
                [ fill "black"
                , y <| toString <| boxHeight / 2
                , x <| toString <| boxWidth / 2
                ]
                [ text <| toString <| xp + (yp * 10) ]
            ]
