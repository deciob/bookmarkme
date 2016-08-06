module Helpers exposing (getTitle)

import Bookmarks.Model exposing (..)


getTitle : Bookmark -> String
getTitle bookmark =
    case bookmark.title of
        Nothing ->
            bookmark.url

        Just title ->
            title
