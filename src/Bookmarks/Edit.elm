module Bookmarks.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit)
import String
import Bookmarks.Model exposing (..)
import Bookmarks.Messages exposing (..)
import Helpers


type alias Arg =
    { msg : BookmarkId -> String -> Msg
    , inputName : String
    , label : String
    , helper : Bookmark -> String
    }


view : Bookmark -> Html Msg
view bookmark =
    div []
        [ h3 [] [ text "Edid Bookmark" ]
        , form bookmark
        ]


form : Bookmark -> Html Msg
form bookmark =
    let
        argsTitle =
            { msg = ChangeTitle
            , inputName = "title"
            , label = "Title"
            , helper = Helpers.getTitle
            }

        argsTags =
            { msg = ChangeTags
            , inputName = "tags"
            , label = "Tags"
            , helper = Helpers.getTags
            }
    in
        Html.form [ onSubmit (Save bookmark.id) ]
            [ inputBlock bookmark argsTitle
            , inputBlock bookmark argsTags
            , button [ type' "submit" ] [ text "Save" ]
            ]


inputBlock : Bookmark -> Arg -> Html Msg
inputBlock bookmark arg =
    div []
        [ label []
            [ text arg.label
            , input
                [ type' "text"
                , name <| String.toLower arg.label
                , onInput <| arg.msg bookmark.id
                , value <| arg.helper bookmark
                ]
                []
            ]
        , pre []
            [ text (arg.helper bookmark) ]
        ]
