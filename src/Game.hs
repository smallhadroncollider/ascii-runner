module Game (play) where

import ClassyPrelude

import Control.Lens ((&), (+~), (.~))

import Brick
import Brick.BChan (newBChan)
import Graphics.Vty (Event(EvKey), Key(KChar), mkVty, defaultConfig)

import qualified Actions (jump, frame)
import Attr (attr)
import Draw (draw)
import Loop (loop, fps)
import Types (Name, UI, Tick(Tick), create, dimensions, position)
import Window (getDimensions)

-- distance per second
speed :: Float
speed = 2

handleTick :: UI -> EventM Name (Next UI)
handleTick ui = do
    let distance = 1 / fromIntegral fps * speed
    s <- liftIO getDimensions
    continue . Actions.frame $ ui & position +~ distance & dimensions .~ s

handleEvent :: UI -> BrickEvent Name Tick -> EventM Name (Next UI)
handleEvent ui (VtyEvent (EvKey (KChar 'q') [])) = halt ui
handleEvent ui (VtyEvent (EvKey (KChar ' ') [])) = continue $ Actions.jump ui
handleEvent ui (AppEvent Tick) = handleTick ui
handleEvent ui _ = continue ui

app :: App UI Tick Name
app = App {
    appDraw = draw
  , appChooseCursor = neverShowCursor
  , appHandleEvent = handleEvent
  , appStartEvent = return
  , appAttrMap = const attr
}

play :: IO ()
play = do
    chan <- newBChan 1
    loop chan
    s <- getDimensions
    void $ customMain (mkVty defaultConfig) (Just chan) app $ create s
