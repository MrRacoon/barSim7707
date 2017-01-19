module Component.Grid exposing (render)

import Html exposing (Html, ul)
import List exposing (map)
import Component.Number

render : List Int -> List Int -> Maybe Int -> Html a
render avail picked lastDrawn =
  ul [] (map (Component.Number.render picked lastDrawn) avail)
