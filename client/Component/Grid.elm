module Component.Grid exposing (render)

import Html exposing (Html, div)
import List exposing (map, take, drop)
import Component.Number

byTen xs =
  case xs of
    [] -> []
    _  -> take 10 xs :: (byTen <| drop 10 xs)

render : List Int -> List Int -> Maybe Int -> Html a
render avail picked lastDrawn =
  let grouped = byTen avail
      rendered = map (map (Component.Number.render picked lastDrawn)) grouped
  in div [] <| map (div []) rendered
