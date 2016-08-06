module Messages exposing (..)

import Bookmarks.Messages


-- This is a Union Type


type Msg
    = BookmarksMsg Bookmarks.Messages.Msg
