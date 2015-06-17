module Pix.Types where
import Haste.App

type ImageHash = JSString
type Tag = JSString
type ImageURL = JSString
type DirURL = JSString

data Backend = Backend {
    backendAddImage   :: ImageHash -> ImageURL -> [Tag] -> IO (),
    backendTagImage   :: ImageHash -> [Tag] -> IO (),
    backendListImages :: Int -> IO [(ImageHash, ImageURL)]
  }
