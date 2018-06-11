module Draw (draw) where

import ClassyPrelude

import Control.Lens ((^.))

import Data.Sequence ((!?))

import Brick (Widget, AttrName, Padding(Pad), vBox, txt, str, withAttr, padTop, padLeft, vBox, emptyWidget)
import Brick.Widgets.Center (center)

import Attr (grass, ground, obstacle)
import Types (Name, UI, Obstacles, State(..), Direction(Level), dimensions, position, player, obstacles, state)

makeRow :: Int -> AttrName -> Char -> Widget Name
makeRow screenWidth attr char = withAttr attr . str $ const char <$> [1 .. screenWidth]

drawObstacle :: Obstacles -> Int -> Char
drawObstacle obs i = if i `elem` obs then 'Y' else ' '

drawObstacles :: Obstacles -> Int -> Int -> Widget Name
drawObstacles obs pos screenWidth = withAttr obstacle . str $ drawObstacle obs <$> [pos .. screenWidth + pos]

legs :: Seq Text
legs = fromList [
        "/\\ /\\"
      , "// /\\"
      , "// //"
      , "/\\ //"
      , "\\\\ /\\"
    ]

drawLegs :: Direction -> Int -> Text
drawLegs jumping i = case jumping of
    Level -> fromMaybe "/\\ /\\" (legs !? ((i `div` 2) `mod` length legs))
    _ -> "// \\\\"

drawSprite :: UI -> Int -> Int -> Widget Name
drawSprite ui i h = padTop (Pad offset) $ padLeft (Pad 3) widget
    where (jumping, jump) = ui ^. player
          offset = h - 4 - jump
          widget = vBox [txt "[===]0", txt (drawLegs jumping i)]

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
      , drawSprite ui i' h
      , padTop (Pad (h - 3)) (vBox rows)
    ]

    where i = ui ^. position
          i' = floor i :: Int
          obs = ui ^. obstacles
          (w, h) = ui ^. dimensions
          score = str $ "Score: " ++ show i'
          rows = [drawObstacles obs i' w, makeRow w grass '=', makeRow w ground 'X']
