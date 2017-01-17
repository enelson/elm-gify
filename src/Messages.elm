module Messages exposing (..)

import Models exposing (..)
import Http


-- MESSAGES

type Msg
  = CloseError
  | ImageResults (Result Http.Error ImageResponse)
  | SearchText String
