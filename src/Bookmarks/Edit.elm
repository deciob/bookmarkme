module Bookmarks.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Bookmarks.Model exposing (..)
import Bookmarks.Messages exposing (..)
import Helpers


view : Bookmark -> Html Msg
view bookmark =
    div []
        [ h3 [] [ text "Edid Bookmark" ]
        , form bookmark
        ]


form : Bookmark -> Html Msg
form bookmark =
    let
        args =
            [ { msg = ChangeTitle
              , inputName = "title"
              , label = "Title"
              , helper = Helpers.getTitle
              }
            , { msg = ChangeTags
              , inputName = "tags"
              , label = "Tags"
              , helper = Helpers.getTags
              }
            ]
    in
        Html.form []
            [ inputTitle bookmark ChangeTitle
              --, inputBlock bookmark "Tags" (Helpers.getTags bookmark) ChangeTags
            , button [ type' "submit" ] [ text "Save" ]
            ]


inputTitle : Bookmark -> (BookmarkId -> String -> Msg) -> Html Msg
inputTitle bookmark msg =
    div []
        [ label []
            [ text "Title"
            , input
                [ type' "text"
                , name "title"
                , onInput <| msg bookmark.id
                , value <| Helpers.getTitle bookmark
                ]
                []
            ]
        , pre []
            [ text (Helpers.getTitle bookmark) ]
        ]
