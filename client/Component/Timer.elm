module Component.Timer exposing (render)

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)
import String exposing (append)
import Time as Time
import Date exposing (fromTime, hour, second)

render model =
  let attrs = [ style [("float", "right")] ]
  in case model.startTime of
    Nothing -> span attrs [ text "Timer: ---" ]
    Just s  ->
      let diff = model.curTime - s
          end  = s * Time.second
          till = end - model.curTime |> fromTime |> second |> toString
      in span attrs [ text <| ("Timer: " ++ till) ]
      -- in span attrs [ text <| ("Next Game in: " ++ till ++ " seconds") ]
