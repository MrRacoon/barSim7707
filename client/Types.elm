module Types exposing (..)

import Time exposing (Time)
import Window exposing (Size)
import Grid.Types as Grid
import Status.Types as Status
import Stats.Types as Stats


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
    | GridMsg Grid.Msg
    | StatusMsg Status.Msg
    | StatsMsg Stats.Msg


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
    , curTime :
        Time
        -- Current clock tick
    , state :
        State
        -- Current Game State
    , screenWidth : Int
    , screenHeight : Int
    , errors : List String
    , grid : Grid.Model
    , status : Status.Model
    , stats : Stats.Model
    }
