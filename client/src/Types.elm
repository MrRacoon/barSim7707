module Types exposing (..)

import UserPage.Types as UserPage

type Msg
  = Receive String
  | Send
  | UserPageMsg UserPage.Msg

type alias Model =
  { user : UserPage.Model
  , count : Int
  }
