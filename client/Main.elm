module Main exposing (..)

import Debug exposing (log)
import Html  exposing (beginnerProgram, Html, div, text)
import List  exposing (map)
import Component.Grid

type Message = NewNumber Int

model = [1,2,3]

update msg model =
  case msg of
    NewNumber x -> model ++ [x]

view model = div [] [Component.Grid.render model]

main = beginnerProgram
  { model  = model
  , view   = view
  , update = update
  }
