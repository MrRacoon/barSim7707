module Main exposing (..)

import Platform.Cmd as Cmd
import Platform.Sub as Sub

import Html exposing (Html, program, div, span, button, text)
import Html.Events exposing (onClick)
import List exposing (map, range, member, length)
import Random exposing (generate, int)
import Time exposing (Time, second, every)

import Component.Grid

type Message
  = Reset
  | GetNumber
  | NewNumber Int
  | TimerTick Time

type alias Model =
  { avail     : List Int
  , picked    : List Int
  , lastDrawn : Maybe Int
  , startTime : Time
  , curTime   : Time
  }

model : Model
model =
  { avail  = range 1 20
  , picked = []
  , lastDrawn = Nothing
  , startTime = 0
  , curTime = 0
  }

init = (model, Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update msg model =
  let newNumber = generate NewNumber (int 1 20)
  in case msg of
    Reset ->
      ({ model | picked = [], lastDrawn = Nothing }, Cmd.none)
    GetNumber ->
      if length model.avail == length model.picked
        then ({ model | picked = [], lastDrawn = Nothing }, Cmd.none)
        else (model, newNumber)
    NewNumber x ->
      if member x model.picked
        then (model, newNumber)
        else ({ model | picked = model.picked ++ [x], lastDrawn = Just x }, Cmd.none)
    TimerTick t ->
      ({ model | curTime = t }, newNumber)

view : Model -> Html Message
view model =
  div
    []
    [ Component.Grid.render model.avail model.picked model.lastDrawn
    , button [onClick GetNumber] [text "NewNum"]
    , button [onClick Reset] [text "Reset"]
    , span [] [ text <| toString model.startTime ++ toString model.curTime]
    , div []
      [ case model.lastDrawn of
        Nothing ->
          text (toString model.lastDrawn)
        Just x ->
          text (toString x)
      ]
    ]

subscriptions model =
  if length model.avail == length model.picked
    then Sub.none
    else Sub.batch
      [ every second TimerTick
      ]

main = program
  { init          = init
  , update        = update
  , subscriptions = subscriptions
  , view          = view
  }
