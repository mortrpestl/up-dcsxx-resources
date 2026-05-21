module Main exposing (main)

import Browser
import Html exposing (Html, div, text, p, input, br)
import Html.Events exposing (onInput)

type Msg
    = MsgNumOne String
    | MsgNumTwo String

type alias Model = {intOne : String, intTwo : String, display : String}

init: {intOne : String, intTwo : String, display : String}
init = { intOne = "", intTwo = "", display = "Please enter integers"}

update: Msg -> Model -> Model
update msg model =
    let
        addTwoIntegerStrings: String -> String -> String
        addTwoIntegerStrings s1 s2 =
            case ((String.toInt s1), (String.toInt s2)) of
                (Just x, Just y) ->
                    String.fromInt (x + y)
                _ ->
                    "Please enter integers"
        updatedModel =
            case msg of
                MsgNumOne s ->
                    {model | intOne = s}
                MsgNumTwo t ->
                    {model | intTwo = t}
        newDisplay = addTwoIntegerStrings updatedModel.intOne updatedModel.intTwo
        in
        { updatedModel | display = newDisplay }
                
view : Model -> Html Msg
view model =
    div []
        [ p [] [text model.display] 
        , input [onInput MsgNumOne] [text model.intOne]
        , br [] []
        , input [onInput MsgNumTwo] [text model.intTwo]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
