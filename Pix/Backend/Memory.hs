module Pix.Backend.Memory where
import Data.IORef
import System.IO.Unsafe
import qualified Data.Map as M
import Pix.Types

{-# NOINLINE memBack #-}
memBack :: IORef (M.Map ImageHash ImageURL)
memBack = unsafePerformIO $ newIORef M.empty

memoryBackend :: Backend
memoryBackend = Backend {
    backendAddImage = \h f _ -> do
      atomicModifyIORef' memBack $ \m -> (M.insert h f m, ()),
    backendTagImage = \h ts -> do
      return (),
    backendListImages = \n -> do
      (take n . M.toList) `fmap` readIORef memBack
  }
