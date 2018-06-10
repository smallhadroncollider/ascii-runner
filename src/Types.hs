{-# LANGUAGE TemplateHaskell #-}
module Types (
    UI
  , Tick(..)
  , Direction(..)
  , Player
  , Name
  , create
  , position
  , dimensions
  , player
) where

import ClassyPrelude

import Control.Lens (makeLenses)

import Window (Dimensions)

data Direction = Up | Down | Level
type Player = (Direction, Int)

data UI = UI {
    _position :: Float
  , _dimensions :: Dimensions
  , _player :: Player
}

$(makeLenses ''UI)

create :: Dimensions -> UI
create s = UI {
        _position = 0
      , _dimensions = s
      , _player = (Level, 0)
    }

data Tick = Tick
type Name = ()
