module Component.StatusBar exposing (render)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style)
import Component.Timer as Timer

statusBarStyles = style
  [ ("width", "99%")
  , ("border", "5px inset grey")
  , ("background-color", "grey")
  ]

brandStyles = style []

timerStyles = style
  [ ("float", "right")
  ]

render model = div
  [statusBarStyles]
  [ span [brandStyles] [ text "BarSim7707"]
  , span [timerStyles] [ Timer.render model ]
  ]
