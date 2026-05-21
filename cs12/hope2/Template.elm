module Main exposing (main)

import Browser
import Html exposing (Html, div, text, p, input, br)
import Html.Events exposing (onInput)

type Msg
    = ...

type alias Model = ...

init: ...
init = ...

update: Msg -> Model -> Model
update msg model =
    ...
                
view : Model -> Html Msg
view model =
    ...

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
