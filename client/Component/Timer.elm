module Component.Timer exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)
import Time exposing (..)

render start cur =
  let attrs = [ style [("float", "right")] ]
  in case start of
    Nothing -> span attrs [ text "Timer: ---" ]
    Just s  ->
      let diff = cur - s
      in span attrs [ text <| toString <| inSeconds diff ]
