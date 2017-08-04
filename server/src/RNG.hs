module RNG where

import System.Random
import Data.List (nub)

randomSample :: (Int, Int) -> Int -> IO [Int]
randomSample range n = newStdGen >>= return . take n . nub . randomRs range

kenoSample :: IO [Int]
kenoSample = randomSample (1, 80) 20
