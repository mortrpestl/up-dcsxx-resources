module Main exposing (main)

import Browser
import Html exposing (Html, button, br, p, div, text, input, Attribute)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style)
import Dict exposing (Dict)

type alias Counter = {num1 : Int, num2 : Int, res : String}
type alias Model = Dict Int Counter

sampleCounter : Counter
sampleCounter = {num1 = 0, num2 = 0, res = "0"}

numOfCards = 20 

init : Model 
init = List.map (\k -> (k, sampleCounter) ) (List.range 1 numOfCards)  |> Dict.fromList

type Msg = 
    Add Int |
    Subtract Int |
    Multiply Int |
    UpdateNum1 Int String |
    UpdateNum2 Int String
     
update : Msg -> Model -> Model
update msg model = 
    case msg of 
        Add id -> 
            case Dict.get id model of
                Nothing -> model
                Just card -> Dict.insert id { card | res = (card.num1 + card.num2) |> String.fromInt } model
                
        Subtract id -> 
            case Dict.get id model of
                Nothing -> model
                Just card -> Dict.insert id { card | res = (card.num1 - card.num2) |> String.fromInt } model
                
        Multiply id ->
            case Dict.get id model of
                Nothing -> model
                Just card -> Dict.insert id { card | res = (card.num1 * card.num2) |> String.fromInt } model
                
        UpdateNum1 id inp -> 
            case Dict.get id model of
                Nothing -> model
                Just card -> Dict.insert id { card | num1 = String.toInt inp |> Maybe.withDefault 0 } model
                
        UpdateNum2 id inp ->
            case Dict.get id model of
                Nothing -> model
                Just card -> Dict.insert id { card | num2 = String.toInt inp |> Maybe.withDefault 0 } model
            
        
cardStyles : List (Attribute Msg)
cardStyles =
    [ style "color" "blue"
    , style "font-size" "16px"
    , style "background-color" "#f0f0f0"
    , style "margin" "1vh"
    , style "display" "flex"
    , style "align-items" "center"
    , style "justify-content" "space-around"
    ]


headerStyles : List (Attribute Msg)
headerStyles =
    [ style "display" "flex"
    , style "justify-content" "space-around"
    ]


viewCard : Model -> Int -> Html Msg
viewCard model id =
    let
        result =
            Dict.get id model
                |> Maybe.map .res
                |> Maybe.withDefault "0"
    in
    div cardStyles
        [ input [ onInput (UpdateNum1 id) ] []
        , input [ onInput (UpdateNum2 id) ] []
        , button [ onClick (Add id) ] [ text "Add" ]
        , button [ onClick (Subtract id) ] [ text "Subtract" ]
        , button [ onClick (Multiply id) ] [ text "Multiply" ]
        , p [] [ text result ]
        ]


view : Model -> Html Msg
view model =
    div []
        (p headerStyles [ text "Calculator Cards" ]
            :: List.map (viewCard model) (List.range 1 numOfCards)
        )
        
    
main : Program () Model Msg
main =
    Browser.sandbox
    { init = init
    , view = view
    ,  update = update
    }
