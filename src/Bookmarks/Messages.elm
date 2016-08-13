module Bookmarks.Messages exposing (..)

import Bookmarks.Model exposing (Bookmark, BookmarkId)
import Http


-- This is a Union Type


type Msg
    = ChangeTitle BookmarkId String
    | ChangeTags BookmarkId String
    | SaveSucceded Bookmark
    | SaveFailed Http.Error
    | FetchAllSucceded (List Bookmark)
    | FetchAllFailed Http.Error
