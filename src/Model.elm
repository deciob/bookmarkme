module Model exposing (..)

import Bookmarks.Model exposing (Bookmark, new)
import Routing


type alias Model =
    { bookmarks : List Bookmark
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { bookmarks = [ new ]
    , route = route
    }
