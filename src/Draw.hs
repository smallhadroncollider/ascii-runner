module Draw (draw) where

import ClassyPrelude

import Control.Lens ((^.))

import Brick (Widget, AttrName, Padding(Pad), vBox, str, withAttr, padTop, padLeft, vBox)
import Attr (grass, ground)
import Types (Name, UI, dimensions, position, player)

makeRow :: Int -> AttrName -> Char -> Widget Name
makeRow screenWidth attr char = withAttr attr . str $ const char <$> [1 .. screenWidth]

drawObstacle :: Int -> Int -> Char
drawObstacle offset i = if (i + offset) > 20 && (i + offset) `mod` 21 == 0 then 'Y' else ' '

drawObstacles :: Int -> Int -> Widget Name
drawObstacles pos screenWidth = str $ drawObstacle pos <$> [1 .. screenWidth]

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
          (w, h) = ui ^. dimensions
          score = str $ "Score: " ++ show i'
          rows = [drawObstacles i' w, makeRow w grass '=' , makeRow w ground 'X']
