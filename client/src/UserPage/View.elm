module UserPage.View exposing (view)

import UserPage.Types exposing (..)

import Html exposing (Html, div, span, form, input, text)
import Html.Attributes exposing (style, class, type_, placeholder, value)
import Html.Events exposing (onInput)
import List exposing (range)

view : Model -> Html Msg
view model =
  div []
    [ form []
      [ input [ type_ "text", placeholder "Name", onInput NameChange ] []
      ]
    ]
