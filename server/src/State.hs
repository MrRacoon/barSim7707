module State where

import Types
import Constants
import qualified Control.Concurrent as Concurrent
import qualified Data.Aeson as JSON
import qualified Data.List as List
import qualified Data.Maybe as Maybe
import qualified Data.Map.Strict as Map
import qualified Safe

onRecieve :: ClientId -> Model -> ClientMsg -> Model
onRecieve clientId state msg = case msg of
  ClientPick playerPick ->
    let updatePick player = player { pick = Just playerPick }
    in state { players = Map.adjust updatePick clientId (players state) }

  ClientRename playerName ->
    let updateName player = player { name = playerName }
    in state { players = Map.adjust updateName clientId (players state) }
