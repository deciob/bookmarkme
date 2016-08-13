module Bookmarks.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Bookmarks.Model exposing (Bookmark)
import Bookmarks.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get listDecoder url
        |> Task.perform FetchAllFailed FetchAllSucceded


listDecoder : Decode.Decoder (List Bookmark)
listDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Bookmark
memberDecoder =
    Decode.object4 Bookmark
        ("id" := Decode.string)
        (Decode.maybe ("title" := Decode.string))
        ("url" := Decode.string)
        (Decode.maybe ("tags" := Decode.string))


url : String
url =
    "http://localhost:8080/api/bookmarks"
