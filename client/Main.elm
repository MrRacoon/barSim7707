module Main exposing (..)

-- import Debug exposing (log)
import Html exposing (..)
import Html.Events exposing (onClick)
import List exposing (map, range)
import Component.Grid
import Maybe

type Message
  = Reset
  | GetNumber
  | NewNumber Int

type alias Model =
  { avail     : List Int
  , picked    : List Int
  , lastDrawn : Maybe Int
  }

init : Model
init =
  { avail  = range 1 20
  , picked = []
  , lastDrawn = Nothing
  }

update : Message -> Model -> Model
update msg model =
  case msg of
    Reset ->
      { model | picked = [], lastDrawn = Nothing }
    GetNumber ->
      update (NewNumber 4) model
    NewNumber x ->
      { model | picked = model.picked ++ [x], lastDrawn = Just 4 }

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

main = beginnerProgram
  { model  = init
  , view   = view
  , update = update
  }
