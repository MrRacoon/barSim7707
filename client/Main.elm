module Main exposing (..)

import Platform.Cmd as Cmd
import Platform.Sub as Sub

import Html exposing (Html, program, div, span, button, text)
import Html.Events exposing (onClick)
import List exposing (map, range, member, length)
import Random exposing (generate, int)
import Time exposing (Time, second, every)

import Component.Grid

type State
  = DuringGame
  | PreGame

type Message
  = Reset
  | GetNumber
  | NewNumber Int
  | TimerTick Time

type alias Model =
  { avail     : List Int
  , picked    : List Int
  , pickCount : Int
  , lastDrawn : Maybe Int
  , startTime : Maybe Time
  , curTime   : Time
  , state     : State
  }

modeli : Model
modeli =
  { avail     = range 1 80
  , picked    = []
  , pickCount = 20
  , lastDrawn = Nothing
  , startTime = Nothing
  , curTime   = 0
  , state     = DuringGame
  }

init = (modeli, Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update msg model =
  let lenAvail  = length model.avail
      newNumber = generate NewNumber (int 1 lenAvail)
  in case msg of

    Reset ->
      ({ model
      | picked = []
      , lastDrawn = Nothing
      , state = DuringGame
      , startTime = Nothing
      }, Cmd.none)

    -- For manualg requests
    GetNumber ->
      if length model.picked == model.pickCount
        then ({ model | picked = [], lastDrawn = Nothing }, Cmd.none)
        else (model, newNumber)

    NewNumber x ->
      if length model.picked == model.pickCount
        then ({ model | state = PreGame, lastDrawn = Nothing, startTime = Nothing }, Cmd.none)
        else if member x model.picked
          then (model, newNumber)
          else ({ model | picked = x :: model.picked, lastDrawn = Just x }, Cmd.none)

    TimerTick t ->
      case model.startTime of
        Nothing -> ({ model | curTime = t, startTime = Just t }, newNumber)
        Just _  -> ({ model | curTime = t }, newNumber)

view : Model -> Html Message
view model =
  div []
    [ Component.Grid.render model
    , button [onClick GetNumber] [text "NewNum"]
    , button [onClick Reset] [text "Reset"]
    ]

subscriptions model =
  case model.state of
    PreGame -> Sub.none
    DuringGame ->
      Sub.batch
        [ every second TimerTick
        ]

main = program
  { init          = init
  , update        = update
  , subscriptions = subscriptions
  , view          = view
  }
