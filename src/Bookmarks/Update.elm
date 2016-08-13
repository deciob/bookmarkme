module Bookmarks.Update exposing (update)

import Bookmarks.Messages exposing (Msg(..))
import Bookmarks.Model exposing (Bookmark, BookmarkId)
import List


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
            let
                newBookmarks =
                    List.map
                        (\bookmark ->
                            if bookmark.id == id then
                                { bookmark | title = Just title }
                            else
                                bookmark
                        )
                        bookmarks
            in
                ( newBookmarks, Cmd.none )

        _ ->
            ( bookmarks, Cmd.none )
