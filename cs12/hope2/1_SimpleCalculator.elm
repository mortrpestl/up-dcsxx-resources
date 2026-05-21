module Main exposing (main)

import Browser
import Html exposing (Html, button, br, p, div, text, input)
import Html.Events exposing (onClick, onInput)


type alias Model = {num1 : Int, num2 : Int, res : String}
init : Model 
init = {num1 = 6, num2 = 7, res = "0"}

type Msg = 
    Add |
    Subtract |
    Multiply |
    UpdateNum1 String |
    UpdateNum2 String
     
update : Msg -> Model -> Model
update msg model = 
    case msg of 
        Add -> { model | res = (model.num1 + model.num2) |> String.fromInt }
        Subtract -> { model | res = (model.num1 - model.num2) |> String.fromInt }
        Multiply -> { model | res = (model.num1 * model.num2) |> String.fromInt }
        UpdateNum1 inp -> { model | num1 = String.toInt inp |> Maybe.withDefault 0 }
        UpdateNum2 inp -> { model | num2 = String.toInt inp |> Maybe.withDefault 0 }
        
view : Model -> Html Msg
view model = 
    div []
        [ input [ onInput (UpdateNum1) ] []
        , input [ onInput (UpdateNum2) ] []
        , br [] []
        , button [ onClick Add ] [ text "Add" ]
        , button [ onClick Subtract ] [ text "Subtract" ]
        , button [ onClick Multiply ] [ text "Multiply" ]
        , p [] [ text model.res ]
        ]
    
main : Program () Model Msg
main =
    Browser.sandbox
    { init = init
    , view = view
    ,  update = update
    }
