module Bookmarks.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Bookmarks.Model exposing (Bookmark, BookmarkId)
import Bookmarks.Messages exposing (..)
import Helpers


fetchAll : Cmd Msg
fetchAll =
    Http.get listDecoder url
        |> Task.perform FetchAllFailed FetchAllSucceded


saveTask : Bookmark -> Task.Task Http.Error Bookmark
saveTask bookmark =
    let
        body =
            memberEncoder bookmark
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PUT"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = saveUrl bookmark.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson memberDecoder


save : Bookmark -> Cmd Msg
save bookmark =
    saveTask bookmark
        |> Task.perform SaveFailed SaveSucceded


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


memberEncoder : Bookmark -> Encode.Value
memberEncoder bookmark =
    let
        list =
            [ ( "id", Encode.string bookmark.id )
            , ( "title", Encode.string <| Helpers.getTitle bookmark )
            , ( "tags", Encode.string <| Helpers.getTags bookmark )
            , ( "url", Encode.string bookmark.id )
            ]
    in
        list
            |> Encode.object


url : String
url =
    "http://localhost:8080/api/bookmarks"


saveUrl : BookmarkId -> String
saveUrl id =
    url ++ "/" ++ id
