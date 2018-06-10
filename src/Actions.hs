module Actions (
    jump
  , frame
) where

import ClassyPrelude

import Control.Lens ((%~))
import Types (Player, Direction(..), UI, Direction(..), player)

jump :: UI -> UI
jump = player %~ startJump

frame :: UI -> UI
frame = player %~ animate

-- internal functions
startJump :: Player -> Player
startJump (Types.Level, _) = (Types.Up, 1)
startJump pl = pl

animate :: Player -> Player
animate (Types.Level, pos) = (Types.Level, pos)
animate (Types.Up, pos)
    | pos < 4 = (Types.Up, pos + 1)
    | otherwise = (Types.Down, pos)
animate (Types.Down, pos)
    | pos > 0 = (Types.Down, pos - 1)
    | otherwise = (Types.Level, 0)
