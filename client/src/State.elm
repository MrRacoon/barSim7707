module State exposing (..)

import WebSocket as Sock
import Platform.Cmd as Cmd
import Platform.Sub as Sub

import Types exposing (..)
import Constants exposing (serverUrl)
import UserPage.State as UserPage
import GameBoard.State as GameBoard

init : (Model, Cmd Msg)
init =
  (
    { user = UserPage.init
    , board = GameBoard.init
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
    Send            -> model ! [ Sock.send serverUrl "poke" ]
    UserPageMsg msg -> { model | user = UserPage.update msg model.user } ! []
    GameBoardMsg msg -> { model | board = GameBoard.update msg model.board } ! []

subscriptions : Model -> Sub Msg
subscriptions model = Sock.listen serverUrl Receive
