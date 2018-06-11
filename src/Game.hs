module Game (play) where

import ClassyPrelude

import Control.Lens ((&), (.~), (^.))
import System.Random (getStdRandom, randomR)

import Brick
import Brick.BChan (newBChan)
import Graphics.Vty (Event(EvKey), Key(KChar, KEnter), mkVty, defaultConfig)

import qualified Actions (restart, jump, frame)
import Attr (attr)
import Draw (draw)
import Loop (loop)
import Types (Name, UI, Tick(Tick), create, speed, dimensions)
import Window (getDimensions)

handleTick :: UI -> EventM Name (Next UI)
handleTick ui = do
    let sp = ui ^. speed
    s <- liftIO getDimensions
    r <- liftIO $ getStdRandom (randomR (sp, sp * 3))
    continue $ Actions.frame r (ui & dimensions .~ s)

handleEvent :: UI -> BrickEvent Name Tick -> EventM Name (Next UI)
handleEvent ui (VtyEvent (EvKey (KChar 'q') [])) = halt ui
handleEvent ui (VtyEvent (EvKey KEnter [])) = continue $ Actions.restart ui
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

getSpeed :: IO Int
getSpeed = do
    args <- getArgs
    return $ case args of
        [sp] -> fromMaybe 10 $ readMay sp
        _ -> 10


play :: IO ()
play = do
    chan <- newBChan 1
    loop chan
    s <- getDimensions
    sp <- getSpeed
    void $ customMain (mkVty defaultConfig) (Just chan) app $ create s sp
