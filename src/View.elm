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
                        [ h4 [ class "media-heading" ]
                             [ text (imageRecord.slug ++ " (Rating: [" ++ imageRecord.rating ++ "])") ]
                        , a [ href url ]
                            [ text url ]
                        ]
                  ]
           ]

viewUrlList : List ImageRecord -> Html Msg
viewUrlList imageRecordList =
    let
        listOfUrls =
          List.map viewUrl imageRecordList
    in
        div [ class "panel panel-success" ]
            [ div [ class "panel-heading" ]
                  [ text "Search Results" ]
            , table [ class "table table-striped" ]
                    [ tbody []
                      listOfUrls
                    ]
            ]

viewError : Model -> Html Msg
viewError model =
    let
        hideError =
          if (String.isEmpty model.error) then
            True
          else
            False
    in
        div [ class "alert alert-danger alert-dismissable", hidden hideError ]
            [ button [ class "close", onClick CloseError ]
                     [ span [ class "glyphicon glyphicon-remove" ] [] ]
            , text model.error
            ]

view : Model -> Html Msg
view model =
    div []
        [ Html.form
                [ class "form-horizontal" ]
                [ div [ class "form-group" ]
                      [ label [ class "col-sm-2 control-label" ] [ text "Enter search: " ]
                      , div [ class "col-md-6" ] [ input [ id "queryString"
                                    , onInput SearchText
                                    , class "form-control"
                              ] []]
                      ]
                -- , div [ class "form-group" ]
                --       [ div [ class "col-sm-offset-2 col-sm-10" ]
                --             [ button [ class "btn btn-primary", onClick (SearchText "cats")]
                --                      [ text "Go" ]
                --             ]
                --       ]
                ]
        , viewUrlList model.images
        , (viewError model)
        ]
