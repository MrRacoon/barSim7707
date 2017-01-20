module Component.Grid exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (style, class)
import List exposing (map, take, drop, length)
import Component.Cell as Cell
import Component.StatusBar as StatusBar

rowAttrs =
  [ class "row"
  , style
    [ ("display", "flex")
    , ("justify-content", "space-between")
    , ("background-color", "darkgrey")
    -- , ("border", "5px ridge red")
    ]
  ]

-- render : List Int -> List Int -> Maybe Int -> Html a
render model =
  let rows = byTen model.avail
      mid  = (length rows) // 2
      (top, btm) =
        rows
          |> map (map (Cell.render model))
          |> map (div rowAttrs)
          |> \rs -> (take mid rs, drop mid rs)
  in div [] (top ++ [StatusBar.render model] ++ btm)

-- =============================================================================

xsByX : Int -> List a -> List (List a)
xsByX n xs =
  case xs of
    [] -> []
    _  -> take n xs :: (byTen <| drop n xs)

byTen : List a -> List (List a)
byTen = xsByX 10
