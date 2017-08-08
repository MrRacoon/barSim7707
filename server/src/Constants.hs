module Constants where

import Data.Time

totalNumOfSpots :: Int
totalNumOfSpots = 80

totalNumOfPicks :: Int
totalNumOfPicks = 20

timeBetweenGames :: DiffTime
timeBetweenGames = secondsToDiffTime 30

timeBetweenPicks :: DiffTime
timeBetweenPicks = secondsToDiffTime 1
