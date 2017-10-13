module Grid.View exposing (..)

import Types exposing (Model)
import Constants exposing (board, padding)
import Html exposing (Html)
import Html.Attributes exposing (style)
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


view : Model -> Html msg
view model =
    svg
        [ height <| toString model.screenHeight
        , width <| toString model.screenWidth
        ]
        ([ rect
            [ height <| toString model.screenHeight
            , width <| toString model.screenWidth
            , fill "grey"
            ]
            []
         ]
            ++ (List.map (drawCell model) board)
        )


drawCell : Model -> ( Float, Float ) -> Svg msg
drawCell model ( xp, yp ) =
    let
        number =
            round <| xp + (yp * 10)

        usableXSpace =
            model.screenWidth - (round <| padding * 12)

        usableYSpace =
            model.screenHeight - (round <| padding * 10)

        boxWidth =
            toFloat usableXSpace / 10

        boxHeight =
            toFloat usableYSpace / 8

        xVal =
            (xp * (boxWidth + padding)) - boxWidth

        yVal =
            yp * (boxHeight + padding)

        fillColor =
            case model.lastDrawn of
                Nothing ->
                    "blue"

                Just num ->
                    if (num == number) then
                        "lightblue"
                    else if (List.member number model.picked) then
                        "yellow"
                    else
                        "blue"

        transformation =
            transform <| "translate(" ++ toString xVal ++ "," ++ toString yVal ++ ")"

        styles =
            []
    in
        g [ transformation ]
            [ rect
                [ fill "lightgrey"
                , width <| toString <| boxWidth + 3
                , height <| toString <| boxHeight + 3
                , x <| toString -3
                , y <| toString -3
                ]
                []
            , rect
                [ fill "black"
                , width <| toString boxWidth
                , height <| toString boxHeight
                ]
                []
            , rect
                [ style styles
                , width <| toString <| boxWidth - 3
                , height <| toString <| boxHeight - 3
                , fill fillColor
                ]
                []
            , text_
                [ fill "black"
                , y <| toString <| boxHeight / 1.5
                , x <| toString <| boxWidth / 3
                , fontSize <| toString 40
                ]
                [ text <| toString <| xp + (yp * 10) ]
            ]
