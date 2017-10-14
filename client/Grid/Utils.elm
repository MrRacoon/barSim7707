module Grid.Utils exposing (..)

import Animation
import Color exposing (blue, green)


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


pickNumber _ maybeStyles =
    fillBlue maybeStyles
