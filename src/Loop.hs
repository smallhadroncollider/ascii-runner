module Loop (loop) where

import ClassyPrelude

import Control.Concurrent (forkIO, threadDelay)
import Brick.BChan (BChan, writeBChan)

import Types (Tick(Tick))

loop :: BChan Tick -> IO ()
loop chan = void . forkIO . forever $ do
    writeBChan chan Tick
    threadDelay 64000
