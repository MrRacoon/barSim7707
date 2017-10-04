module Types exposing (..)

import Time exposing (Time)


type State
    = DuringGame
    | PreGame


type Msg
    = Reset
    | GetNumber
    | NewNumber Int
    | TimerTick Time
    | WaitTick Time


type alias Model =
    { avail :
        List Int
        -- Available picks
    , picked :
        List Int
        -- Already picked
    , pickCount :
        Int
        -- Number of picks to pick each round
    , lastDrawn :
        Maybe Int
        -- Last pick
    , startTime :
        Maybe Time
        -- Round start time
    , waitTime : Time
    , tickTime : Time
    , curTime :
        Time
        -- Current clock tick
    , state :
        State
        -- Current Game State
    }
