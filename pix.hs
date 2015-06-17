{-# LANGUAGE OverloadedStrings #-}
import Haste.App
import Haste.DOM.JSString
import qualified Haste.JSString as Str
import Pix.Config
import Pix.Backend
import Haste.Events

cfg = defaultConfig

main = runApp (mkConfig "localhost" 24681) $ do
  list <- remote $ liftIO . backendListImages (cfgBackend cfg)
  upload <- remote $ uploadFile cfg

  runClient $ do
    withElem "images" $ \is -> do
      urls <- onServer $ list <.> 10
      imgs <- flip mapM urls $ \i -> do
        newElem "img" `with` ["src" =: Str.concat [cfgImgDir cfg, "/", snd i]]
      setChildren is imgs

    withElems ["uploadfile", "doupload"] $ \[f, btn] -> do
      btn `onEvent` Click $ \_ -> do
        Just fd <- getFileData f 0
        onServer $ upload <.> fd
      return ()
