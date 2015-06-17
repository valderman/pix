{-# LANGUAGE OverloadedStrings #-}
module Pix.Config (
    Config,
    defaultConfig,
    cfgImgDir, cfgThumbDir, cfgBackend,
    Backend (..), ImageHash, Tag, ImageURL
  ) where
import Pix.Types
import Pix.Backend.Memory

data Config = Config {
    -- | Directory to contain full-size images. Must be writable by the Pix
    --   server user.
    cfgImgDir :: DirURL,

    -- | Directory to contain image thumbnails. Must be writable by the Pix
    --   server user.
    cfgThumbDir :: DirURL,

    -- | Backend to use for image storage.
    cfgBackend :: Backend
  }

defaultConfig :: Config
defaultConfig = Config {
    cfgImgDir   = "images",
    cfgThumbDir = "thumbs",
    cfgBackend  = memoryBackend
  }
