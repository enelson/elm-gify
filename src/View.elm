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
        tr []
           [ div  [ class "media" ]
                  [ div [ class "media-left" ]
                        [ img [ src url, height 100, width 100, class "thumbnail" ]
                              []
                        ]
                  , div [ class "media-body" ]
                        [ h4 [ class "media-heading" ] [ text "URL" ]
                        , a [ href url ]
                            [ text imageRecord.slug ]
                        ]
                  ]
           ]

viewUrlList : List ImageRecord -> Html Msg
viewUrlList imageRecordList =
    let
        listOfUrls =
          List.map viewUrl imageRecordList
    in
        table [ class "table table-striped" ]
              [ tbody []
                      listOfUrls
              ]

view : Model -> Html Msg
view model =
    div []
        [ Html.form
                [ class "form-horizontal" ]
                [ div [ class "form-group" ]
                      [ label [ class "col-sm-2 control-label" ] [ text "Enter search: " ]
                      , div [ class "col-sm-10" ]
                            [ input [ id "queryString"
                                    , onInput SearchText
                                    , class "form-control"
                                    ] []
                            ]
                      ]
                , div [ class "form-group" ]
                      [ div [ class "col-sm-offset-2 col-sm-10" ]
                            [ button [ class "btn btn-primary", onClick (SearchText "cats")]
                                     [ text "Go" ]
                            ]
                      ]
                ]
        , div []
              [ viewUrlList model.images ]
        , div [ class "alert alert-danger", hidden True ]
              [ text model.error ]
        ]
