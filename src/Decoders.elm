module Decoders exposing (..)

import Models exposing (..)
import Json.Decode as Decode exposing (Decoder, field, succeed, dict)
import Maybe exposing (..)


-- DECODERS

imageDecoder : Decoder Image
imageDecoder =
    Decode.map Image
        (Decode.maybe (field "url" Decode.string))

imageRecordDecoder : Decoder ImageRecord
imageRecordDecoder =
    Decode.map6 ImageRecord
        (field "id" Decode.string)
        (field "type" Decode.string)
        (field "url" Decode.string)
        (field "rating" Decode.string)
        (field "slug" Decode.string)
        (field "images" (Decode.dict imageDecoder))

metaDecoder : Decoder Meta
metaDecoder =
    Decode.map3 Meta
        (field "status" Decode.int)
        (field "msg" Decode.string)
        (field "response_id" Decode.string)

paginationDecoder : Decoder Pagination
paginationDecoder =
    Decode.map3 Pagination
        (field "total_count" Decode.int)
        (field "count" Decode.int)
        (field "offset" Decode.int)

imageResponseDecoder : Decoder ImageResponse
imageResponseDecoder =
    Decode.map3 ImageResponse
        (field "data" (Decode.list imageRecordDecoder))
        (field "meta" metaDecoder)
        (field "pagination" paginationDecoder)
