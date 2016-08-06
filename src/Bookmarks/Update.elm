module Bookmarks.Update exposing (update)

import Bookmarks.Messages exposing (Msg(..))
import Bookmarks.Model exposing (Bookmark)


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
