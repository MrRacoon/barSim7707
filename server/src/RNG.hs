module RNG where

import System.Random
import Data.List (nub)

randomSample :: (Int, Int) -> Int -> IO [Int]
randomSample range n = fmap (take n . nub . randomRs range) newStdGen

kenoSample :: IO [Int]
kenoSample = randomSample (1, 80) 20
