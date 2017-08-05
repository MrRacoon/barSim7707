module View exposing (..)

import Types exposing (..)

import Html exposing (Html, div, p, button, text, map)
import Html.Events exposing (onClick)

import UserPage.View as UserPage
import GameBoard.View as GameBoard

view : Model -> Html Msg
view model =
  div []
    (
      [ p [] [ text <| "Pokes: " ++ toString model ]
      , button [ onClick Send ] [ text "Poke others" ]
      , map UserPageMsg (UserPage.view model.user)
      , map GameBoardMsg (GameBoard.view model.board)
      ]
    )
