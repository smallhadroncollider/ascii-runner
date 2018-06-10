module Draw (draw) where

import ClassyPrelude

import Control.Lens ((^.))

import Brick (Widget, AttrName, Padding(Pad), vBox, txt, str, withAttr, padTop, padLeft, vBox, emptyWidget)
import Brick.Widgets.Center (center)

import Attr (grass, ground, obstacle)
import Types (Name, UI, Obstacles, State(..), dimensions, position, player, obstacles, state)

makeRow :: Int -> AttrName -> Char -> Widget Name
makeRow screenWidth attr char = withAttr attr . str $ const char <$> [1 .. screenWidth]

drawObstacle :: Obstacles -> Int -> Char
drawObstacle obs i = if i `elem` obs then 'Y' else ' '

drawObstacles :: Obstacles -> Int -> Int -> Widget Name
drawObstacles obs pos screenWidth = withAttr obstacle . str $ drawObstacle obs <$> [pos .. screenWidth + pos]

drawSprite :: UI -> Int -> Widget Name
drawSprite ui h = padTop (Pad offset) $ padLeft (Pad 3) widget
    where (_, jump) = ui ^. player
          offset = h - 5 - jump
          widget = vBox [txt "O", txt "+", txt "W"]

drawGameOver :: UI -> Widget Name
drawGameOver ui = case ui ^. state of
    GameOver -> center . vBox $ txt <$> [
            "     Game Over!     "
          , "Press Enter to retry"
        ]
    Playing -> emptyWidget

draw :: UI -> [Widget Name]
draw ui = [
        score
      , drawGameOver ui
      , drawSprite ui h
      , padTop (Pad (h - 3)) (vBox rows)
    ]

    where i = ui ^. position
          i' = floor i :: Int
          obs = ui ^. obstacles
          (w, h) = ui ^. dimensions
          score = str $ "Score: " ++ show i'
          rows = [drawObstacles obs i' w, makeRow w grass '=', makeRow w ground 'X']
