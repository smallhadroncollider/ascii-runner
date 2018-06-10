module Game (play) where

import ClassyPrelude

import Control.Lens ((&), (+~), (.~))

import Brick
import Brick.BChan (newBChan)
import Graphics.Vty (Event(EvKey), Key(KChar), defAttr, mkVty, defaultConfig)

import Draw (draw)
import Loop (loop)
import Types (Name, UI, Tick(Tick), create, dimensions, position)
import Window (getDimensions)

handleTick :: UI -> EventM Name (Next UI)
handleTick ui = do
    s <- liftIO getDimensions
    continue $ ui & position +~ 1 & dimensions .~ s

handleEvent :: UI -> BrickEvent Name Tick -> EventM Name (Next UI)
handleEvent ui (VtyEvent (EvKey (KChar 'q') [])) = halt ui
handleEvent ui (AppEvent Tick) = handleTick ui
handleEvent ui _ = continue ui

app :: App UI Tick Name
app = App {
    appDraw = draw
  , appChooseCursor = neverShowCursor
  , appHandleEvent = handleEvent
  , appStartEvent = return
  , appAttrMap = const $ attrMap defAttr []
}

play :: IO ()
play = do
    chan <- newBChan 1
    loop chan
    s <- getDimensions
    void $ customMain (mkVty defaultConfig) (Just chan) app $ create s
