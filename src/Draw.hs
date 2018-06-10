module Draw (draw) where

import ClassyPrelude

import Control.Lens ((^.))

import Brick (vBox, txt, Widget)
import Types (Name, UI, dimensions, position)

period :: Float
period = 4 * pi

pixel :: Float -> Float -> Char
pixel y i = if y > cos i then '█' else ' '

makeRow :: Float -> Float -> Float -> Text
makeRow xStart screenWidth y = pack $ pixel y <$> [xStart, xStart + w .. period + xStart]
    where w = period / screenWidth

draw :: UI -> [Widget Name]
draw ui = do
    let i = ui ^. position
    let (w, h) = ui ^. dimensions
    let h' = 2 / (fromIntegral h - 1)
    [vBox $ txt . makeRow (fromIntegral i * 0.1) (fromIntegral w - 1) <$> [-1, (-1 + h') .. 1]]
