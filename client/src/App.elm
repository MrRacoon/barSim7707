module App exposing (..)

import Html exposing (program)

import Types exposing (..)
import State as State
import View as View

main : Program Never Model Msg
main = program
  { init          = State.init
  , update        = State.update
  , subscriptions = State.subscriptions
  , view          = View.view
  }
