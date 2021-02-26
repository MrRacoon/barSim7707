module Constants exposing (..)

import Time exposing (Time, second)


pickCount : Int
pickCount =
    20


waitTime : Time
waitTime =
    60 * second


tickTime : Time
tickTime =
    3 * second


padding : Float
padding =
    10


rows : Int
rows =
    8


cols : Int
cols =
    10


totalNumbers : Int
totalNumbers =
    80


board : List ( Float, Float )
board =
    let
        makeCell yVal xVal =
            ( toFloat xVal, toFloat yVal )

        makeRow index =
            List.map (makeCell index) (List.range 1 cols)
    in
        List.concatMap makeRow (List.range 0 (rows - 1))
