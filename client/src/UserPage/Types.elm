module UserPage.Types exposing (..)

type Msg
  = NameChange String
  | PickNumber String

type alias Model =
  { username : String
  , pickedNumber : String
  }
