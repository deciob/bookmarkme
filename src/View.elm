module View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (..)
import Html.App
import Messages exposing (Msg(..))
import Model exposing (Model)
import Bookmarks.List
import Bookmarks.Edit
import Routing exposing (Route(..))
import Bookmarks.Model exposing (BookmarkId)
import List


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ page model
        ]


page : Model -> Html Msg
page model =
    case model.route of
        BookmarksRoute ->
            bookmarks model

        BookmarkRoute bookmarkId ->
            bookmarkEditPage model bookmarkId

        NotFoundRoute ->
            notFoundView


bookmarks : Model -> Html Msg
bookmarks model =
    Html.App.map BookmarksMsg <| Bookmarks.List.view model.bookmarks


bookmarkEditPage : Model -> BookmarkId -> Html Msg
bookmarkEditPage model bookmarkId =
    let
        maybeBookmark =
            model.bookmarks
                |> List.filter (\bookmark -> bookmark.id == bookmarkId)
                |> List.head
    in
        case maybeBookmark of
            Just bookmark ->
                Html.App.map BookmarksMsg <| Bookmarks.Edit.view bookmark

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
