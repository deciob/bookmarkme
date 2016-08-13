module Helpers exposing (..)

import Bookmarks.Model exposing (..)


getTitle : Bookmark -> String
getTitle bookmark =
    case bookmark.title of
        Nothing ->
            bookmark.url

        Just title ->
            title


getTags : Bookmark -> String
getTags bookmark =
    case bookmark.tags of
        Nothing ->
            "No tags"

        Just tags ->
            tags
