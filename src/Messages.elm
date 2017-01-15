module Messages exposing (..)

import Models exposing (..)
import Http


-- MESSAGES

type Msg
  = ImageSearch
  | ImageResults (Result Http.Error ImageResponse)
  | SearchText String
