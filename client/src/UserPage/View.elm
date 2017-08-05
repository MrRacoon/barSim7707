module UserPage.View exposing (view)

import UserPage.Types exposing (..)

import Html exposing (Html, div, span, form, input, select, option, text)
import Html.Attributes exposing (style, class, type_, placeholder, value)
import Html.Events exposing (onInput)
import List exposing (range)

makeOptions : String -> Html Msg
makeOptions num = option [ value num ] [ text num ]

options : List (Html Msg)
options = List.map (makeOptions << toString) (range 1 80)

view : Model -> Html Msg
view model =
  div []
    [ form []
      [ input [ type_ "text", placeholder "Name", onInput NameChange ] []
      , select [ onInput PickNumber ] options
      ]
    ]
