module Loop (
    loop
  , fps
) where

import ClassyPrelude

import Control.Concurrent (forkIO, threadDelay)
import Brick.BChan (BChan, writeBChan)

import Types (Tick(Tick))

fps :: Int
fps = 15

delay :: Int
delay = 1000000 `div` fps

loop :: BChan Tick -> IO ()
loop chan = void . forkIO . forever $ do
    writeBChan chan Tick
    threadDelay delay
