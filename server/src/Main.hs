{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import qualified Control.Concurrent             as Concurrent
import qualified Control.Exception              as Exception
import qualified Control.Monad                  as Monad
import qualified Data.Aeson                     as JSON
import qualified Data.List                      as List
import qualified Data.Map                       as Map
import qualified Data.Maybe                     as Maybe
import qualified Data.Text                      as Text
import qualified Network.HTTP.Types             as Http
import qualified Network.Wai                    as Wai
import qualified Network.Wai.Handler.Warp       as Warp
import qualified Network.Wai.Handler.WebSockets as WS
import qualified Network.WebSockets             as WS
import qualified Safe
import Types
import Debug.Trace

-- =============================================================================
-- Broadcasting

broadcast :: ClientId -> Concurrent.MVar Model -> Text.Text -> IO ()
broadcast clientId stateRef msg = do
  state <- Concurrent.readMVar stateRef
  let otherClients = map connection $ Map.elems $ players state
  Monad.forM_ otherClients $ \conn ->
    WS.sendTextData conn msg

playerUpdate :: Model -> IO ()
playerUpdate state = do
  let ps = Map.elems $ players $ trace (show state) state
      conns = map connection ps
      msg = JSON.encode $ UpdatePlayers ps
  Monad.forM_ conns $ \conn -> WS.sendTextData conn $ trace (show msg) msg

-- =============================================================================
-- (Dis)Connect handlers

connectClient :: WS.Connection -> Concurrent.MVar Model -> IO ClientId
connectClient conn stateRef =
  Concurrent.modifyMVar stateRef $ \state -> do
    let clientId  = nextId state
        nextState = addPlayer conn state
    return (trace ("Player Added: " ++ show nextState) nextState, clientId)

disconnectClient :: ClientId -> Concurrent.MVar Model -> IO ()
disconnectClient clientId stateRef = Concurrent.modifyMVar_ stateRef $ \state ->
  return $ rmPlayer clientId state

-- =============================================================================
-- Listeners

-- listen :: WS.Connection -> ClientId -> Concurrent.MVar Model -> IO ()
listen conn clientId stateRef = Monad.forever $ do
  msg <- WS.receiveDataMessage conn
  case msg of
    WS.Text t ->
      let text = JSON.decode t
      in case text of
        Just (ClientPick p) -> do
          state <- Concurrent.readMVar stateRef
          let newState = updatePlayerPick clientId p state
          playerUpdate newState
          Concurrent.putMVar stateRef $ trace (show newState) newState
        Just (ClientRename n) -> do
          state <- Concurrent.readMVar stateRef
          let newState = updatePlayerName clientId n state
          playerUpdate newState
          Concurrent.putMVar stateRef $ trace (show newState) newState
        Nothing -> do
          state <- Concurrent.readMVar stateRef
          playerUpdate state
          Concurrent.putMVar stateRef $ trace (show state) state


-- =============================================================================
-- Apps

wsApp :: Concurrent.MVar Model -> WS.ServerApp
wsApp stateRef pendingConn = do
  conn <- WS.acceptRequest pendingConn
  clientId <- connectClient conn stateRef
  WS.forkPingThread conn 30
  Exception.finally
    (listen conn clientId stateRef)
    (disconnectClient clientId stateRef)

httpApp :: Wai.Application
httpApp _ respond = respond $ Wai.responseLBS Http.status400 [] "Not a websocket request"

-- =============================================================================

main :: IO ()
main = do
  state <- Concurrent.newMVar initialModel
  Warp.run 3000 $ WS.websocketsOr
    WS.defaultConnectionOptions
    (wsApp state)
    httpApp
