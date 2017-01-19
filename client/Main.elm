module Main exposing (..)

-- import Debug exposing (log)
import Html exposing (..)
import Html.Events exposing (onClick)
import List exposing (map, range)
import Component.Grid
import Platform.Cmd as Cmd
import Platform.Sub as Sub

type Message
  = Reset
  | GetNumber
  | NewNumber Int

type alias Model =
  { avail     : List Int
  , picked    : List Int
  , lastDrawn : Maybe Int
  }

model : Model
model =
  { avail  = range 1 20
  , picked = []
  , lastDrawn = Nothing
  }

init = (model, Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update msg model =
  case msg of
    Reset ->
      ({ model | picked = [], lastDrawn = Nothing }, Cmd.none)
    GetNumber ->
      update (NewNumber 4) model
    NewNumber x ->
      ({ model | picked = model.picked ++ [x], lastDrawn = Just 4 }, Cmd.none)

view : Model -> Html Message
view model =
  div
    []
    [ Component.Grid.render model.avail model.picked model.lastDrawn
    , button [onClick GetNumber] [text "NewNum"]
    , button [onClick Reset] [text "Reset"]
    , div
      []
      [ case model.lastDrawn of
        Nothing ->
          text (toString model.lastDrawn)
        Just x ->
          text (toString x)
      ]
    ]

subscriptions model = Sub.none

main = program
  { init          = init
  , update        = update
  , subscriptions = subscriptions
  , view          = view
  }
