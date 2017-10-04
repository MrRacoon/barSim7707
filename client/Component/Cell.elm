module Component.Cell exposing (render)

import Types exposing (Model)
import Html exposing (Html, Attribute, span, text)
import Html.Attributes exposing (style, class)
import List exposing (member)


type alias Style =
    ( String, String )


baseStyles : List Style
baseStyles =
    [ ( "border", "3px outset grey" )
    , ( "margin", "2px" )
    , ( "padding", "20px" )
    , ( "height", "20px" )
    , ( "width", "20px" )
    , ( "text-align", "center" )
    , ( "font-family", "arial" )
    ]


lastStyles : List Style
lastStyles =
    [ ( "color", "#0000FF" )
    , ( "background-color", "lightblue" )
    , ( "border", "3px outset lightblue" )
    ]


pickedStyles : List Style
pickedStyles =
    [ ( "color", "#00FF00" )
    , ( "background-color", "green" )
    , ( "border", "3px outset green" )
    ]


defaultStyles : List Style
defaultStyles =
    [ ( "color", "#000000" )
    ]


styles : Model -> Int -> Attribute msg
styles model cur =
    style <| baseStyles ++ cellStyle model cur


cellStyle : Model -> Int -> List Style
cellStyle model cur =
    if member cur model.picked then
        case model.lastDrawn of
            Nothing ->
                pickedStyles

            Just x ->
                if x == cur then
                    lastStyles
                else
                    pickedStyles
    else
        defaultStyles


render : Model -> Int -> Html msg
render model cur =
    span
        [ class "cell", styles model cur ]
        [ text (toString cur) ]
