module Window (
    Dimensions
  , getDimensions
) where

import ClassyPrelude

import qualified System.Console.Terminal.Size as S (Window(..), size)

type Dimensions = (Int, Int)

deMaybe :: Maybe (S.Window Int) -> Dimensions
deMaybe (Just (S.Window h w)) = (w, h)
deMaybe Nothing = (80, 30)

getDimensions :: IO Dimensions
getDimensions = deMaybe <$> S.size
