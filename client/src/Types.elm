module Types exposing (..)

import UserPage.Types as UserPage
import GameBoard.Types as GameBoard

type Msg
  = Receive String
  | Send
  | UserPageMsg UserPage.Msg
  | GameBoardMsg GameBoard.Msg

type alias Model =
  { user : UserPage.Model
  , board : GameBoard.Model
  , count : Int
  }
