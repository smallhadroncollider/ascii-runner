module Actions (
    jump
  , frame
) where

import ClassyPrelude

import Control.Lens ((&), (^.), (%~), (+~))
import Types (Player, Direction(..), UI, Direction(..), player, position, obstacles)
import Loop (fps)

-- distance per second
speed :: Float
speed = 10

jump :: UI -> UI
jump = player %~ startJump

frame :: UI -> UI
frame ui = ui & player %~ animate & position +~ distance
    where distance = if collision ui then 0 else 1 / fromIntegral fps * speed

-- internal functions
collision :: UI -> Bool
collision ui = pos `elem` (ui ^. obstacles) && jumpHeight < 1
    where pos = floor (ui ^. position) + 3
          (_, jumpHeight) = ui ^. player

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
