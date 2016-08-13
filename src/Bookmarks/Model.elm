module Bookmarks.Model exposing (..)


type alias BookmarkId =
    String


type alias Bookmark =
    { id : BookmarkId
    , title : Maybe String
    , url : String
    , tags : Maybe String
    }



-- Tmp


new : Bookmark
new =
    { id = "0"
    , title = Just "Placeholder"
    , url = "www.xxx"
    , tags = Nothing
    }
