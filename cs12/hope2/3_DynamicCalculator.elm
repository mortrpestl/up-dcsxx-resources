module Main exposing (main)

import Browser
import Html exposing (Html, button, br, p, div, text, input, Attribute)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style, value)
import Dict exposing (Dict)

type alias Counter = {num1 : Int, num2 : Int, res : String}
type alias Model = {cards : Dict Int Counter, nextIndex : Int}

sampleCounter : Counter
sampleCounter = {num1 = 0, num2 = 0, res = "0"}

numOfCards = 20 

init : Model 
init = { cards = (List.map (\k -> (k, sampleCounter) ) (List.range 1 numOfCards)  |> Dict.fromList), nextIndex = numOfCards+1}

type Msg = 
    Add Int |
    Subtract Int |
    Multiply Int |
    UpdateNum1 Int String |
    UpdateNum2 Int String |
    AddCard |
    RemoveCard Int
     
update : Msg -> Model -> Model
update msg model =
    let
        updateCard id f =
            case Dict.get id model.cards of
                Nothing -> model
                Just card -> { model | cards = Dict.insert id (f card) model.cards }
    in
    case msg of
        Add id ->
            updateCard id (\card -> { card | res = String.fromInt (card.num1 + card.num2) })

        Subtract id ->
            updateCard id (\card -> { card | res = String.fromInt (card.num1 - card.num2) })

        Multiply id ->
            updateCard id (\card -> { card | res = String.fromInt (card.num1 * card.num2) })

        UpdateNum1 id inp ->
            updateCard id (\card -> { card | num1 = Maybe.withDefault 0 (String.toInt inp) })

        UpdateNum2 id inp ->
            updateCard id (\card -> { card | num2 = Maybe.withDefault 0 (String.toInt inp) })

        AddCard ->
            let 
                newId = model.nextIndex + 1
            in 
                { model | cards = Dict.insert newId { num1 = 0, num2 = 0, res = "0" } model.cards
                       , nextIndex = newId }

        RemoveCard id ->
            { model | cards = Dict.remove id model.cards }


            
        
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
            Dict.get id model.cards
                |> Maybe.map .res
                |> Maybe.withDefault "0"
                
        num1 =
            Dict.get id model.cards
                |> Maybe.map .num1
                |> Maybe.withDefault 0
            
        num2 =
            Dict.get id model.cards
                |> Maybe.map .num2
                |> Maybe.withDefault 0
            
    in
    div cardStyles
        [ input [ onInput (UpdateNum1 id), value (String.fromInt num1) ] []
        , input [ onInput (UpdateNum2 id), value (String.fromInt num2) ] []
        , button [ onClick (Add id) ] [ text "Add" ]
        , button [ onClick (Subtract id) ] [ text "Subtract" ]
        , button [ onClick (Multiply id) ] [ text "Multiply" ]
        , button [ onClick (RemoveCard id) ] [ text "Remove" ]
        , p [] [ text result ]
        ]


view : Model -> Html Msg
view model =
    div []
        ([ p headerStyles [ text "Calculator Cards" ]
         , button [ onClick AddCard ] [ text "Add Card" ] ]
            ++ List.map (viewCard model) (Dict.keys model.cards) 
        )
        
    
main : Program () Model Msg
main =
    Browser.sandbox
    { init = init
    , view = view
    ,  update = update
    }
