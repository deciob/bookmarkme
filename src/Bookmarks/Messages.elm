module Bookmarks.Messages exposing (..)

import Bookmarks.Model exposing (Bookmark)
import Http


-- This is a Union Type
type Msg
    = FetchAllSucceded (List Bookmark)
    | FetchAllFailed Http.Error
