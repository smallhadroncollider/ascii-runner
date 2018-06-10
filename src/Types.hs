{-# LANGUAGE TemplateHaskell #-}
module Types (
    UI
  , Tick(..)
  , Name
  , create
  , position
  , dimensions
) where

import ClassyPrelude

import Control.Lens (makeLenses)

import Window (Dimensions)

data UI = UI {
    _position :: Int
  , _dimensions :: Dimensions
}

$(makeLenses ''UI)

create :: Dimensions -> UI
create s = UI {
        _position = 0
      , _dimensions = s
    }

data Tick = Tick
type Name = ()
