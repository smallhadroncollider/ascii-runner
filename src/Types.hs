{-# LANGUAGE TemplateHaskell #-}
module Types (
    UI
  , Tick(..)
  , Direction(..)
  , Player
  , Obstacles
  , Name
  , create
  , position
  , dimensions
  , player
  , obstacles
) where

import ClassyPrelude

import Control.Lens (makeLenses)

import Window (Dimensions)

data Direction = Up | Down | Level
type Player = (Direction, Int)
type Obstacles = [Int]

data UI = UI {
    _position :: Float
  , _dimensions :: Dimensions
  , _player :: Player
  , _obstacles :: [Int]
}

$(makeLenses ''UI)

create :: Dimensions -> UI
create s = UI {
        _position = 0
      , _dimensions = s
      , _player = (Level, 0)
      , _obstacles = [fst s, fst s + 18 .. 300]
    }

data Tick = Tick
type Name = ()
