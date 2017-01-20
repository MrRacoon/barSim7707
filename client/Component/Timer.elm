module Component.Timer exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)
import String exposing (append)
import Time as Time
import Date exposing (fromTime, minute, second)

render model =
  let attrs = [ style [("float", "right")] ]
  in case model.startTime of
    Nothing -> span attrs []
    Just s  ->
      let diff = model.curTime - s
          end  = s + model.waitTime
          till = end - model.curTime |> fromTime
          secs = till |> second |> toString
          mins = till |> minute |> toString
      in span attrs [ text <| ("Time until next game: " ++ mins ++ ":" ++ secs) ]
