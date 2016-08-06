module Update exposing (..)

import Messages exposing (Msg(..))
import Model exposing (Model)
import Bookmarks.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        BookmarksMsg subMsg ->
            let
                ( updatedBookmarks, cmd ) =
                    Bookmarks.Update.update subMsg model.bookmarks
            in
                ( { model | bookmarks = updatedBookmarks }, Cmd.map BookmarksMsg cmd )
