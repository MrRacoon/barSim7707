module Component.Number exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)
import List exposing (member)


numberColor : List Int -> Maybe Int -> Int -> String
numberColor picked lastDrawn cur =
  let isPicked     = member cur picked
      defaultColor = "#000000"
      pickedColor  = "#00FF00"
      lastColor    = "#0000FF"
  in if isPicked
    then case lastDrawn of
      Nothing -> pickedColor
      Just x ->
        if x == cur
          then lastColor
          else pickedColor
    else defaultColor

render : List Int -> Maybe Int -> Int -> Html a
render picked lastDrawn cur =
  span
    [ style
      [ ("color", numberColor picked lastDrawn cur)
      , ("margin", "10px")
      ]
    ]
    [ text (toString cur) ]
