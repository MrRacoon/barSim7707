module Component.Number exposing (render)

import Html exposing (Html, li, text)
import Html.Attributes exposing (style)
import List exposing (member)


defaultColor : String
defaultColor = "#000000"

pickedColor : String
pickedColor = "#00FF00"

numberColor : List Int -> Int -> String
numberColor picked cur =
  if member cur picked
    then pickedColor
    else defaultColor

render : List Int -> Maybe Int -> Int -> Html a
render picked lastDrawn cur =
  li
    [ style
      [("color", numberColor picked cur)
      ]
    ]
    [ text (toString cur) ]
