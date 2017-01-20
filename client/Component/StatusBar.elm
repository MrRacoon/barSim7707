module Component.StatusBar exposing (render)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style)
import Component.Timer as Timer

render model =
  let attrs =
    [ style [ ("width", "99%")
            , ("border", "5px inset purple")
            ]
    ]
  in div attrs
    [ span [] [ text <| "Picked: " ++ (toString model.picked) ]
    , Timer.render model.startTime model.curTime
    ]
