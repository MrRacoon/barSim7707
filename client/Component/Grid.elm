module Component.Grid exposing (render)

import Html exposing (ul)
import List exposing (map)
import Component.Number

render nums = ul [] (map Component.Number.render nums)
