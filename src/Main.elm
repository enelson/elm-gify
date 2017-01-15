module Main exposing (..)

import Messages exposing (..)
import Models exposing (..)
import Update exposing (..)
import View exposing (..)
import Html exposing (..)


initialModel : Model
initialModel =
    { images = []
    , error = ""
    }



main =
  Html.program
    { init = (initialModel, Cmd.none)
    , update = update
    , view = view
    , subscriptions = (\_ -> Sub.none)
    }
