module Component.Grid exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import List exposing (map, take, drop)
import Component.Number
import Component.StatusBar

flexContainer  = ("display", "flex")
justifyContent = ("justify-content", "space-between")
background     = ("background-color", "grey")
border         = ("border", "5px solid red")

rowAttrs =
  [ style
    [ flexContainer
    , justifyContent
    , background
    ]
  ]

byTen xs =
  case xs of
    [] -> []
    _  -> take 10 xs :: (byTen <| drop 10 xs)

render : List Int -> List Int -> Maybe Int -> Html a
render avail picked lastDrawn =
  let grouped = byTen avail
      rendered = map (map (Component.Number.render picked lastDrawn)) grouped
      rows = map (div rowAttrs) rendered
      (top, btm) = (take 4 rows, drop 4 rows)
  in div [] (top ++ [Component.StatusBar.render picked] ++ btm)
