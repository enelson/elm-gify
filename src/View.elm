module View exposing (..)

import Messages exposing (..)
import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Dict exposing (..)
import Maybe exposing (..)


-- VIEWS

viewUrl : ImageRecord -> Html Msg
viewUrl imageRecord =
    let
        key =
            withDefault "fixed_height" (List.head (Dict.keys imageRecord.images))

        image =
            Dict.get key imageRecord.images

        url =
            case image of
              Just imageObj ->
                case imageObj.url of
                  Just url ->
                      withDefault "" imageObj.url

                  Nothing ->
                      ""

              Nothing ->
                ""
    in
        li []
           [ span []
                  [ a [ href url ]
                      [ text imageRecord.slug ]
                  , img [ src url ]
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
              , input [ id "queryString"
                      , onInput SearchText
                      ] []
              , button [onClick (SearchText "cats")] [text "Go"]
              ]
        , div []
              [ viewUrlList model.images ]
        , div []
              [ text model.error ]
        ]
