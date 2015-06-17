module Pix.Backend where
import Haste.App
import Haste.Binary
import Data.IORef
import System.IO.Unsafe
import qualified Data.ByteString.Lazy as BS
import Pix.Config

{-# NOINLINE filectr #-}
filectr :: IORef Int
filectr = unsafePerformIO $ newIORef 0

uploadFile :: Config -> Blob -> Server ()
uploadFile cfg f = do
  n <- liftIO $ atomicModifyIORef filectr $ \n -> (n+1, n)
  bd <- getBlobData f
  let fn = show n ++ ".jpg"
  liftIO $ do
    BS.writeFile (toString (cfgImgDir cfg) ++ "/" ++ fn) (toByteString bd)
    backendAddImage (cfgBackend cfg) (toJSString n) (toJSString fn) []
    putStrLn "Wrote image OK!"
