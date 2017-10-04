module Grid.View exposing (..)

import Types exposing (Model)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style, height, width)


view : Model -> Html msg
view model =
    let
        heightBound =
            model.screenHeight / 16

        widthBound =
            model.screenWidth / 20

        boxBounds =
            if heightBound < widthBound then
                heightBound
            else
                widthBound
    in
        div []
            (List.map (mkCell boxBounds) (List.range 1 80))


mkCell : Float -> Int -> Html msg
mkCell bound num =
    let
        left =
            (((num - 1) % 10) * round bound * 2)

        styles =
            [ ( "position", "absolute" )
            , ( "padding", toString bound ++ "px" )
            , ( "left", toString left ++ "px" )
            , ( "width", toString (left + ((round bound) * 2)) ++ "px" )
            , ( "top", toString (floor (toFloat (num - 1) / 10) * round bound) ++ "px" )
            , ( "border", "1px black dotted" )
            ]
    in
        span [ style styles ] [ text <| toString num ]
