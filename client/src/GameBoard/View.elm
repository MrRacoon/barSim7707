module GameBoard.View exposing (..)

import List exposing (map)
import List.Extra exposing (splitAt)
import Set exposing (member)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Material.Grid exposing (grid, cell, size, Device(..))

import GameBoard.Types exposing (..)

cellStyles : List (String, String)
cellStyles =
  [ ("display", "inline")
  , ("margin", "10px")
  , ("padding", "10px")
  , ("cursor", "pointer")
  , ("border", "solid grey 2px")
  ]

pickedStyles : List (String, String)
pickedStyles = cellStyles ++
  [ ("background-color", "grey")
  ]

selectedStyles : List (String, String)
selectedStyles = cellStyles ++
  [ ("background-color", "yellow")
  ]

numCell : Model -> String -> Html Msg
numCell model num =
  let styles = if member num model.selected then pickedStyles else cellStyles
  in span [ onClick (SelectNumber num), style styles ] [ text num ]

createCell : Model -> String -> Material.Grid.Cell Msg
createCell model num =
  cell
    [ size All 1 ]
    [ numCell model num ]

boardStyles : List (String, String)
boardStyles =
  [ ("margin", "10px")
  ]

view : Model -> Html Msg
view model =
  div [ style boardStyles ]
    ( model.available
      |> map (createCell model)
      |> splitByTen
      |> map (grid [])
    )

-- =============================================================================

splitByTen : List a -> List (List a)
splitByTen xs =
  let (y, ys) = splitAt 10 xs
  in case ys of
    [] -> [y]
    _  -> y :: splitByTen ys
