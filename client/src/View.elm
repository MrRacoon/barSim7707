module View exposing (..)

import Html exposing (Html, div, p, button, text, map)
import Html.Events exposing (onClick)

import UserPage.View as UserPage
import Types exposing (..)

view : Model -> Html Msg
view model =
  div []
    (
      [ p [] [ text <| "Pokes: " ++ toString model ]
      , button [ onClick Send ] [ text "Poke others" ]
      , map UserPageMsg (UserPage.view model.user)
      ]
    )
