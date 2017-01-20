module Component.Number exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)
import List exposing (member)

border         = ("border", "5px solid red")

cellAttrs =
  [ style
    [ border
    ]
  ]

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
    [ style [ ("border", "5px outset purple")
            , ("color", numberColor picked lastDrawn cur)
            , ("margin", "5px")
            , ("padding", "5px")
            , ("height", "20px")
            , ("width", "20px")
            , ("text-align", "center")
            ]
    ]
  in span attrs [ text (toString cur) ]
