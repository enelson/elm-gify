module View exposing (..)

import Messages exposing (..)
import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- VIEWS

getImageUrl : ImageRecord -> String
getImageUrl imageRecord =
    case imageRecord.images.fixed_width_small_still of
        Just image ->
            image.url

        Nothing ->
            imageRecord.images.fixed_height.url

viewUrl : ImageRecord -> Html Msg
viewUrl imageRecord =
    li []
       [ span []
              [ a [ href imageRecord.images.fixed_height.url ]
                  [ text imageRecord.slug ]
              , img [ src (getImageUrl imageRecord) ]
                    []
              ]
       ]

viewUrlList : List ImageRecord -> Html Msg
viewUrlList imageRecordList =
    let
        listOfUrls =
          List.map viewUrl imageRecordList
    in
        ul [] listOfUrls

view : Model -> Html Msg
view model =
    div []
        [ div []
              [
                text "Enter search: "
                , input [] []
                , button [onClick ImageSearch] [text "Go"]
              ]
        , div []
              [ viewUrlList model.images ]
        , div []
              [ text model.error ]
        ]
