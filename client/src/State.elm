module State exposing (..)

import WebSocket as Sock
import Platform.Cmd as Cmd
import Platform.Sub as Sub

import Types exposing (..)
import UserPage.State as UserPage

wsUrl : String
wsUrl = "ws://localhost:3000"

init : (Model, Cmd Msg)
init =
  (
    { user = UserPage.init
    , count = 0
    }
    , Cmd.none
  )

incrementCount : Model -> Model
incrementCount model = { model | count = model.count + 1 }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Receive "poke"  -> (incrementCount model) ! []
    Receive _       -> model ! []
    Send            -> model ! [ Sock.send wsUrl "poke" ]
    UserPageMsg msg -> { model | user = UserPage.update msg model.user } ! []

subscriptions : Model -> Sub Msg
subscriptions model = Sock.listen wsUrl Receive
