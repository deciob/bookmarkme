module Main exposing (..)

import Messages exposing (Msg(..))
import Model exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Bookmarks.Commands exposing (fetchAll)
import Navigation
import Routing exposing (Route)



init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map BookmarksMsg fetchAll )


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
        _ = Debug.log "currentRoute" (currentRoute)
    in
        ( { model | route = currentRoute }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never
main =
    Navigation.program Routing.parser
    --Html.App.program
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
