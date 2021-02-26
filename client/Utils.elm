module Utils exposing (..)

import Animation
import Color exposing (blue, green)
import Constants exposing (padding)


type alias Location =
    { num : Int
    , col : Float
    , row : Float
    , height : Float
    , width : Float
    , x : Float
    , y : Float
    , screenHeight : Int
    , screenWidth : Int
    }


location : Int -> Int -> Int -> Location
location screenHeight screenWidth num =
    let
        ( col, row ) =
            numberCoordinates num

        usableXSpace =
            screenWidth - (round <| padding * 12)

        usableYSpace =
            screenHeight - (round <| padding * 10)

        boxWidth =
            toFloat usableXSpace / 10

        boxHeight =
            toFloat usableYSpace / 8

        x =
            (col * (boxWidth + padding)) - boxWidth

        y =
            row * (boxHeight + padding)
    in
        { num = num
        , height = boxHeight
        , width = boxWidth
        , row = row
        , col = col
        , x = x
        , y = y
        , screenHeight = screenHeight
        , screenWidth = screenWidth
        }


numberCoordinates : Int -> ( Float, Float )
numberCoordinates n =
    let
        num =
            toFloat n

        x =
            ((+) 1) <| toFloat <| (floor <| num - 1) % 10

        y =
            toFloat <| floor <| (num - 1) / 10
    in
        ( x, y )


fillBlue : Animation.State -> Animation.State
fillBlue style =
    Animation.interrupt
        [ Animation.to
            [ Animation.fill blue
            ]
        , Animation.to
            [ Animation.fill green
            ]
        ]
        style



-- pickNumber : Maybe Animation.State -> Maybe Animation.State
