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

styles picked lastDrawn cur =
  let cellStyles = cellStyle picked lastDrawn cur
  in style <| baseStyles ++ cellStyles

render : List Int -> Maybe Int -> Int -> Html a
render picked lastDrawn cur =
  let attrs =
    [ class "cell"
    , styles picked lastDrawn cur
    ]
      children = [ text (toString cur) ]
  in span attrs children

-- =============================================================================

cellStyle : List Int -> Maybe Int -> Int -> List (String, String)
cellStyle picked lastDrawn cur =
  if member cur picked
    then case lastDrawn of
      Nothing -> pickedStyles
      Just x -> if x == cur then lastStyles else pickedStyles
    else defaultStyles
