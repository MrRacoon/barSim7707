module Constants exposing (..)

import Time exposing (Time, second)


pickCount : Int
pickCount =
    10


waitTime : Time
waitTime =
    10 * second


tickTime : Time
tickTime =
    3 * second
