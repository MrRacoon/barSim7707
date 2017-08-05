module UserPage.State exposing (..)

import UserPage.Types exposing (..)

init : Model
init = Model ""

update : Msg -> Model -> Model
update msg model = case msg of
  NameChange str -> { model | username = str }
