module Update exposing (..)

import Messages exposing (..)
import Models exposing (..)
import Http exposing (..)
import Decoders exposing (..)


-- UPDATES

url : String
url =
    "http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC&limit=10"

queryImages : Cmd Msg
queryImages =
    imageResponseDecoder
      |> Http.get url
      |> Http.send ImageResults

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ImageSearch ->
            ( model, queryImages )

        ImageResults (Ok result) ->
            ( { model | images = result.data }, Cmd.none )

        ImageResults (Err error) ->
            ( { model | error = (toString error) }, Cmd.none )
