module Component.Grid exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import List exposing (map, take, drop)
import Component.Number as Cell
import Component.StatusBar as StatusBar

rowAttrs =
  [ style
    [ ("display", "flex")
    , ("justify-content", "space-between")
    , ("background-color", "grey")
    , ("border", "5px ridge red")
    ]
  ]

xsByX n xs =
  case xs of
    [] -> []
    _  -> take n xs :: (byTen <| drop n xs)

byTen = xsByX 10

-- render : List Int -> List Int -> Maybe Int -> Html a
render model =
  let (top, btm) =
    byTen model.avail
      |> map (map (Cell.render model.picked model.lastDrawn))
      |> map (div rowAttrs)
      |> \rows -> (take 4 rows, drop 4 rows)
  in div []
    (top ++ [StatusBar.render model] ++ btm)
