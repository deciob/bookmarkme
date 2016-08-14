module Bookmarks.Update exposing (update)

import Bookmarks.Commands exposing (save)
import Bookmarks.Messages exposing (Msg(..))
import Bookmarks.Model exposing (Bookmark, BookmarkId)
import List


updateInput : BookmarkId -> String -> String -> List Bookmark -> List Bookmark
updateInput id text name bookmarks =
    List.map
        (\bookmark ->
            if bookmark.id == id then
                case name of
                    "title" ->
                        { bookmark | title = Just text }

                    "tags" ->
                        { bookmark | tags = Just text }

                    _ ->
                        bookmark
            else
                bookmark
        )
        bookmarks


saveBookmarkCmds : BookmarkId -> List Bookmark -> List (Cmd Msg)
saveBookmarkCmds id bookmarks =
    List.map
        (\bookmark ->
            if bookmark.id == id then
                save bookmark
            else
                Cmd.none
        )
        bookmarks


update : Msg -> List Bookmark -> ( List Bookmark, Cmd Msg )
update message bookmarks =
    case message of
        FetchAllSucceded newBookmarks ->
            ( newBookmarks, Cmd.none )

        FetchAllFailed err ->
            let
                _ =
                    Debug.log "FetchAllFailed" (err)
            in
                ( bookmarks, Cmd.none )

        ChangeTitle id title ->
            ( updateInput id title "title" bookmarks, Cmd.none )

        ChangeTags id tags ->
            ( updateInput id tags "tags" bookmarks, Cmd.none )

        Save id ->
            ( bookmarks, saveBookmarkCmds id bookmarks |> Cmd.batch )

        --SaveSucceded newBookkmark ->
        _ ->
            ( bookmarks, Cmd.none )
