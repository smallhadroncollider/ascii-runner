module Attr (
    attr
  , grass
  , ground
) where

import Brick (AttrMap, AttrName, attrMap, fg)
import Graphics.Vty (defAttr, green, yellow)

grass, ground :: AttrName
grass = "grass"
ground = "ground"

attr :: AttrMap
attr = attrMap defAttr [
        (grass, fg green)
      , (ground, fg yellow)
    ]
