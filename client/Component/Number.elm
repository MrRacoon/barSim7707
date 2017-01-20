module Component.Number exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style, class)
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
  let attrs =
    [ class "cell"
    , style [ ("border", "2px outset grey")
            , ("color", numberColor picked lastDrawn cur)
            , ("margin", "5px")
            , ("padding", "5px")
            , ("height", "20px")
            , ("width", "20px")
            , ("text-align", "center")
            ]
    ]
      children = [ text (toString cur) ]
  in span attrs children
