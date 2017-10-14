module Grid.Utils exposing (..)


numberCoordinates : Float -> ( Float, Float )
numberCoordinates num =
    let
        x =
            ((+) 1) <| toFloat <| (floor <| num - 1) % 10

        y =
            toFloat <| floor <| (num - 1) / 10
    in
        ( x, y )
