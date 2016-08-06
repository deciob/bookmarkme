module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)
import Bookmarks.Model exposing (BookmarkId)


type Route
    = BookmarksRoute
    | BookmarkRoute BookmarkId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format BookmarksRoute (s "")
        , format BookmarkRoute (s "bookmarks" </> string)
        , format BookmarksRoute (s "bookmarks")
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
