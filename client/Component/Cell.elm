module Component.Cell exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style, class)
import List exposing (member)

baseStyles =
  [ ("border", "3px outset grey")
  , ("margin", "5px")
  , ("padding", "5px")
  , ("height", "20px")
  , ("width", "20px")
  , ("text-align", "center")
  ]

pickedStyles  = [("color", "#00FF00"), ("background-color", "green")]
lastStyles    = [("color", "#0000FF"), ("background-color", "lightblue")]
defaultStyles = [("color", "#000000")]

styles model cur = style <| baseStyles ++ cellStyle model cur

-- render : List Int -> Maybe Int -> Int -> Html a
render model cur = span
  [ class "cell" , styles model cur ]
  [ text (toString cur) ]

-- =============================================================================

-- cellStyle : List Int -> Maybe Int -> Int -> List (String, String)
cellStyle model cur =
  if member cur model.picked
    then case model.lastDrawn of
      Nothing -> pickedStyles
      Just x -> if x == cur then lastStyles else pickedStyles
    else defaultStyles
