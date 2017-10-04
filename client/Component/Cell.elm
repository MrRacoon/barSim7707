module Component.Cell exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style, class)
import List exposing (member)


baseStyles =
    [ ( "border", "3px outset grey" )
    , ( "margin", "2px" )
    , ( "padding", "20px" )
    , ( "height", "20px" )
    , ( "width", "20px" )
    , ( "text-align", "center" )
    , ( "font-family", "arial" )
    ]


lastStyles =
    [ ( "color", "#0000FF" )
    , ( "background-color", "lightblue" )
    , ( "border", "3px outset lightblue" )
    ]


pickedStyles =
    [ ( "color", "#00FF00" )
    , ( "background-color", "green" )
    , ( "border", "3px outset green" )
    ]


defaultStyles =
    [ ( "color", "#000000" )
    ]


styles model cur =
    style <| baseStyles ++ cellStyle model cur


render model cur =
    span
        [ class "cell", styles model cur ]
        [ text (toString cur) ]


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
