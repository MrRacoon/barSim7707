module Component.Number exposing (render)

import Html exposing (Html, li, text)
import Html.Attributes exposing (style)


defaultColor : String
defaultColor = "#000000"

pickedColor : String
pickedColor = "#AF32A1"

numberColor : Maybe Int -> Int -> String
numberColor lastDrawn cur =
  case lastDrawn of
    Nothing -> defaultColor
    Just x  ->
      if cur == x
        then pickedColor
        else defaultColor

render : List Int -> Maybe Int -> Int -> Html a
render picked lastDrawn cur =
  li
    [ style
      [("color", numberColor lastDrawn cur)
      ]
    ]
    [ text (toString cur) ]
