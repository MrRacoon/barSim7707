module Grid.View exposing (..)

import Types exposing (Model)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, rect)
import Svg.Attributes exposing (height, width, x, y, fill)


padding : Int
padding =
    10


rows : Int
rows =
    8


cells : Int
cells =
    10


board : List ( Int, Int )
board =
    let
        makeCell yVal xVal =
            ( xVal, yVal )

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


drawCell : Model -> ( Int, Int ) -> Svg msg
drawCell model ( xp, yp ) =
    let
        boxWidth =
            10

        boxHeight =
            10

        xVal =
            xp * (boxWidth + padding)

        yVal =
            yp * (boxHeight + padding)

        styles =
            []
    in
        rect
            [ style styles
            , width <| toString boxWidth
            , height <| toString boxHeight
            , x <| toString xVal
            , y <| toString yVal
            , fill "blue"
            ]
            []
