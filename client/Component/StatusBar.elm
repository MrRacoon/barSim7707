module Component.StatusBar exposing (render)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style)
import Component.Timer as Timer

styles = style
  [ ("width", "99%")
  , ("border", "5px inset grey")
  , ("background-color", "grey")
  ]

render model =
  let attrs = [ styles ]
  in div attrs
    [ span [] [ text <| "Picked: " ++ (toString model.picked) ]
    , Timer.render model.startTime model.curTime
    ]
