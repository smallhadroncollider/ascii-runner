module Draw (draw) where

import ClassyPrelude

import Control.Lens ((^.))

import Brick (Widget, AttrName, Padding(Pad), vBox, str, withAttr, padTop, padLeft, vBox)
import Attr (grass, ground)
import Types (Name, UI, Obstacles, dimensions, position, player, obstacles)

makeRow :: Int -> AttrName -> Char -> Widget Name
makeRow screenWidth attr char = withAttr attr . str $ const char <$> [1 .. screenWidth]

drawObstacle :: Obstacles -> Int -> Char
drawObstacle obs i = if i `elem` obs then 'Y' else ' '

drawObstacles :: Obstacles -> Int -> Int -> Widget Name
drawObstacles obs pos screenWidth = str $ drawObstacle obs <$> [pos .. screenWidth + pos]

drawSprite :: UI -> Int -> Widget Name
drawSprite ui h = padTop (Pad offset) $ padLeft (Pad 3) widget
    where (_, jump) = ui ^. player
          offset = h - 5 - jump
          widget = vBox [str "O", str "+", str "W"]

draw :: UI -> [Widget Name]
draw ui = [
        score
      , drawSprite ui h
      , padTop (Pad (h - 3)) (vBox rows)
    ]

    where i = ui ^. position
          i' = floor i :: Int
          obs = ui ^. obstacles
          (w, h) = ui ^. dimensions
          score = str $ "Score: " ++ show i'
          rows = [drawObstacles obs i' w, makeRow w grass '=' , makeRow w ground 'X']
