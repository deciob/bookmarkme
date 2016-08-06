module Bookmarks.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bookmarks.Model exposing (..)
import Bookmarks.Messages exposing (..)
import Helpers


view : Bookmark -> Html Msg
view bookmark =
    div []
        [ p [] [ text bookmark.id ]
        , form bookmark
        ]

form : Bookmark -> Html Msg
form bookmark =
    Html.form []
        [ p [] [ text (Helpers.getTitle bookmark) ]
        , input [ type' "text", name "title" ] []
        ]
