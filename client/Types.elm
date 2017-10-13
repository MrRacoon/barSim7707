module Types exposing (..)

import Time exposing (Time)
import Window exposing (Size)


type State
    = DuringGame
    | PreGame


type Msg
    = Reset
    | GetNumber
    | NewNumber Int
    | TimerTick Time
    | WaitTick Time
    | ScreenResize Size


type alias Model =
    { avail :
        List Int
        -- Available picks
    , picked :
        List Int
        -- Already picked
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
    , screenWidth : Int
    , screenHeight : Int
    , errors : List String
    }