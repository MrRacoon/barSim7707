{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module Types where

import GHC.Generics
import Data.Aeson (FromJSON(..), ToJSON(..), (.=), object)
import qualified Data.Text as Text
import qualified Network.Wai.Handler.WebSockets as WS
import qualified Network.WebSockets             as WS
import Data.Map.Strict                          as Map
import Data.Time (UTCTime, DiffTime)

-- =============================================================================

type TimeStarted = UTCTime
type TimeLeft    = DiffTime
type ClientId    = Int
type Pick        = Int
type Name        = Text.Text

-- =============================================================================

data GameState = Playing | Waiting
  deriving (Generic, Show)

instance FromJSON GameState
instance ToJSON GameState

data Player = Player
  { name       :: Name
  , pick       :: Maybe Pick
  , connection :: WS.Connection
  } deriving (Generic)

instance Show Player where
  show (Player n p _) = "Player { name: " ++ Text.unpack n ++ ", pick: " ++ show p ++ "}"

-- instance Read Player

instance ToJSON Player where
  toJSON (Player n p _) =
    object ["name" .= n, "pick" .= p]

-- =============================================================================

data ClientMsg
  = ClientRename Name
  | ClientPick Pick
    deriving (Generic, Show)

instance FromJSON ClientMsg
instance ToJSON ClientMsg

data ServerMsg
  = ServerPick Pick
  | UpdatePlayers [Player]
  | StateChange GameState
    deriving (Generic, Show)

instance ToJSON ServerMsg

-- =============================================================================

data Model = Model
  { players     :: Map.Map ClientId Player
  , gameState   :: GameState
  , remaining   :: DiffTime
  , numbers     :: [Pick]
  , picked      :: [Pick]
  }

-- I'm not supposed to use show like this...
instance Show Model where
  show model
    =  "players:  [" ++ show (Map.elems $ players model) ++ "]\n"
    ++ "state:    [" ++ show (gameState model) ++ "]\n"
    ++ "ramining: [" ++ show (remaining model) ++ "]\n"
    ++ "numbers:  [" ++ show (numbers model) ++ "]\n"
    ++ "picked:   [" ++ show (picked model) ++ "]\n"

initialModel = Model Map.empty Waiting 0 [] []

nextId :: Model -> ClientId
nextId = Map.size . players

addPlayer conn state =
  let clientId  = nextId state
      newPlayer = Player Text.empty Nothing conn
  in state
    { players = Map.insert clientId newPlayer $ players state
    }

rmPlayer clientId state =
  state
    { players = Map.delete clientId $ players state
    }

updatePlayerName clientId newName state =
  let p  = players state ! clientId
      up = p { name = newName }
  in state
    { players = Map.insert clientId up $ players state
    }

updatePlayerPick clientId newPick state =
  let p  = players state ! clientId
      up = p { pick = Just newPick }
  in state
    { players = Map.insert clientId up $ players state
    }
