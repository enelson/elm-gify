module Models exposing (..)

import Maybe exposing (..)
import Dict exposing (..)


-- MODELS

type alias Image =
  { url : Maybe String
  }

type alias ImageRecord =
  { id : String
  , typeVal : String
  , url : String
  , rating : String
  , slug : String
  , images : Dict String Image
  }

type alias Meta =
  { status : Int
  , msg : String
  , response_id : String
  }

type alias Pagination =
  { total_count : Int
  , count : Int
  , offset : Int
  }

type alias ImageResponse =
  { data : List ImageRecord
  , meta : Meta
  , pagination : Pagination
  }

type alias Model =
  { images : List ImageRecord
  , error : String
  }
