module Bookmarks.List exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bookmarks.Model exposing (..)
import Bookmarks.Messages exposing (..)
import Helpers


view : List Bookmark -> Html Msg
view bookmarks =
    div []
        [ list bookmarks
        ]


list : List Bookmark -> Html Msg
list bookmarks =
    div [ class "list" ]
        [ ul []
            (List.map bookmarkRow bookmarks)
        ]


bookmarkRow : Bookmark -> Html Msg
bookmarkRow bookmark =
    li []
        [ a [ href ("./#bookmarks/" ++ bookmark.id) ] [ text "Edit" ]
        , text (" - " ++ (Helpers.getTitle bookmark))
        ]
