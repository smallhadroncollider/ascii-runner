module Draw (draw) where

import ClassyPrelude

import Control.Lens ((^.))

import Brick (Widget, AttrName, Padding(Pad), vBox, str, withAttr, padTop, padLeft, vBox)
import Attr (grass, ground)
import Types (Name, UI, dimensions, position, player)

makeRow :: Int -> AttrName -> Char -> Widget Name
makeRow screenWidth attr char = withAttr attr . str $ const char <$> [1 .. screenWidth]

drawSprite :: UI -> Int -> Widget Name
drawSprite ui h = padTop (Pad offset) $ padLeft (Pad 3) widget
    where (_, jump) = ui ^. player
          offset = h - 5 - jump
          widget = vBox [str "O", str "+", str "W"]

draw :: UI -> [Widget Name]
draw ui = [
        score
      , drawSprite ui h
      , padTop (Pad (h - 2)) (vBox rows)
    ]

    where i = ui ^. position
          (w, h) = ui ^. dimensions
          score = str $ "Score: " ++ show (floor i :: Int)
          rows = [makeRow w grass '=' , makeRow w ground 'X']
