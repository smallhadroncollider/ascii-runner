module Actions (
    jump
  , frame
) where

import ClassyPrelude

import Control.Lens ((&), (^.), (.~), (%~), (+~))
import Types (Player, Direction(..), UI, Direction(..), State(..), reset, player, position, obstacles, state, speed)
import Loop (fps)

jump :: UI -> UI
jump ui = case ui ^. state of
    Playing -> ui & player %~ startJump
    GameOver -> reset ui

frame :: UI -> UI
frame ui = ui & state .~ st & player %~ animate & position +~ distance
    where gameOver = collision ui
          distance = if gameOver then 0 else 1 / fromIntegral fps * fromIntegral (ui ^. speed)
          st = if gameOver then GameOver else Playing

-- internal functions
collision :: UI -> Bool
collision ui = pos `elem` (ui ^. obstacles) && jumpHeight < 2
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
