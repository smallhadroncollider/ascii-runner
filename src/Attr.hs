module Attr (
    attr
  , grass
  , ground
  , obstacle
) where

import Brick (AttrMap, AttrName, attrMap, fg)
import Graphics.Vty (defAttr, green, yellow, red)

grass, ground, obstacle :: AttrName
grass = "grass"
ground = "ground"
obstacle = "obstacle"

attr :: AttrMap
attr = attrMap defAttr [
        (grass, fg green)
      , (ground, fg yellow)
      , (obstacle, fg red)
    ]
