module PrimitiveCalculator exposing (main)

import Browser
import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, style)

type alias Model = Int 

init : Model
init = 0

type Msg = 
    Increment | Decrement

update :  Msg -> Model -> Model
update msg model = 
    case msg of
        Increment -> model + 1
        Decrement -> model - 1
buttonStyle : List (Html.Attribute Msg)

buttonStyle =
    [ style "width" "20%" ]

view : Model -> Html Msg
view model = 
    div [ style "display" "flex" 
        , style "align-items" "center" 
        , style "justify-content" "space-around" 
        ] 
        [ p [] [ text "Counter" ]
        , button ([ onClick Increment ] ++ buttonStyle) [ text "+" ]
        , p [] [ text (String.fromInt model) ]
        , button ([ onClick Decrement ] ++ buttonStyle) [ text "-" ]
    ]

main : Program () Model Msg 
main = 
    Browser.sandbox 
        { init = init
        , view = view
        , update = update
        }