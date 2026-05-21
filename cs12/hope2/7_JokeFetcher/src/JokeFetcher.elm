module Main exposing (main)

import Browser
import Debug
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Http

type Msg =
    MsgGotJoke (Result Msg.Error String)

type Model =



main = 
    Browser.sandbox {
    init = init 
    view = view
    update = update
    subscriptions = subscriptions
    }