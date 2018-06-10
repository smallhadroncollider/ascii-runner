module Actions (
    jump
  , frame
  , restart
) where

import ClassyPrelude

import Control.Lens ((&), (^.), (.~), (%~), (+~))
import Types (Player, Direction(..), UI, Direction(..), State(..), Obstacles, reset, player, position, obstacles, state, speed)
import Loop (fps)

restart :: UI -> UI
restart ui = case ui ^. state of
    GameOver -> Types.reset ui
    _ -> ui

jump :: UI -> UI
jump ui = case ui ^. state of
    Playing -> ui & player %~ startJump
    _ -> ui

frame :: UI -> UI
frame ui = case ui ^. state of
    Playing -> nextFrame ui
    _ -> ui

-- internal functions
nextFrame :: UI -> UI
nextFrame ui = ui
    & state .~ st
    & player %~ animate
    & position +~ distance
    & obstacles %~ trimObstacles ui

    where gameOver = collision ui
          distance = if gameOver then 0 else 1 / fromIntegral fps * fromIntegral (ui ^. speed)
          st = if gameOver then GameOver else Playing

trimObstacles :: UI -> Obstacles -> Obstacles
trimObstacles ui = filter (> pos)
    where pos = floor $ ui ^. position

collision :: UI -> Bool
collision ui = next < pos + 2 && next > pos - 2 && jumpHeight < 2
    where pos = floor (ui ^. position) + 3
          next = fromMaybe 0 $ headMay (ui ^. obstacles)
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
