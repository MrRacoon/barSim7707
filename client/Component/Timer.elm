module Component.Timer exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)
import Time exposing (inMinutes, inSeconds)
import Date exposing (fromTime, hour, second)
import String exposing (append)



render start cur =
  let attrs = [ style [("float", "right")] ]
  in case start of
    Nothing -> span attrs [ text "Timer: ---" ]
    Just s  ->
      let diff = cur - s
          min  = hour <| fromTime diff
          sec  = second <| fromTime diff
      in span attrs [ text <| ("Timer: " ++ (toString min) ++ ":" ++ (toString sec)) ]
