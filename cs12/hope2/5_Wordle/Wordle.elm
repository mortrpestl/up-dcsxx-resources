module Wordle exposing (main)

import Browser
import Html exposing (div, p, text, button, br, input)
import Html.Attributes exposing (value, style, placeholder, disabled)
import Html.Events exposing (onInput, onClick)

import Dict exposing (Dict)

type GameOver = 
    Victory |
    Defeat |
    Ongoing

type alias Model = 
    { guesses : List (String, List Status)
    , wordToGuess : String
    , numGuesses : Int
    , currentGuess : String
    , error : String
    , gameOver : GameOver
    }

wordInMind = "misskonasiya"
numberOfGuesses = 6

len = (String.length) wordInMind
init : Model
init = 
    { guesses = []
    , wordToGuess = String.toUpper wordInMind
    , numGuesses = numberOfGuesses
    , currentGuess = ""
    , error = ""
    , gameOver = Ongoing
    }

type Msg = 
    SubmitGuess |
    UpdateWord String

validWord word =
    (String.length word) == (String.length wordInMind) && String.all Char.isAlpha word
    -- if no length constraint, make sure to dis-count the empty case

update msg model =
    case msg of
        SubmitGuess -> 
            if not (validWord model.currentGuess) then
                { model | error = "Please use a/an " ++ (len |> String.fromInt) ++ "-letter alphanumeric word." }
            else
                { model | 
                    guesses = model.guesses ++ [(model.currentGuess, determineColors model model.currentGuess)]
                    , numGuesses = model.numGuesses - 1
                    , currentGuess = ""
                    , error = "" 
                    , gameOver = 
                        if model.currentGuess == model.wordToGuess then
                            Victory
                        else if model.numGuesses-1 == 0 then
                            Defeat
                        else 
                            Ongoing
                            }
        UpdateWord word -> 
            { model | currentGuess = String.toUpper word }


type Status = 
    Green | 
    Yellow | 
    Gray |
    Undecided

determineColors model guess =
    let 
        charsCorrect = String.toList (String.toUpper model.wordToGuess)
        charsGuessed = String.toList (String.toUpper guess)

        -- green check
        listGreen = List.map2 (\c1 c2 -> if c1==c2 then Green else Undecided) charsCorrect charsGuessed

        -- yellow and gray check
        -- INSIGHTS: map2 doesnt take tuples, but two lists
        listYellowGreen = List.map2 (\cguess status -> case status of 
            Green -> Green 
            _ -> (if List.member cguess charsCorrect && status /= Green then Yellow else Gray)) charsGuessed listGreen
    in
        listYellowGreen

corrColor color = 
    case color of 
        Green -> "green"
        Yellow -> "#ccbc43"
        Gray -> "gray"
        Undecided -> "gray"


viewWordRow word status =
    let 
        characters = String.toList word
    in
        div [ style "display" "flex"
            , style "align-items" "center"
            , style "justify-content" "center" ]
        (List.map2 (\c s -> div 
            [ style "background-color" (corrColor s)
            , style "height" "40px"
            , style "width" "40px"
            , style "margin" "0 1px"
            , style "display" "flex"
            , style "align-items" "center"
            , style "justify-content" "space-around"
            , style "font-family" "monospace"
            , style "color" "white"
            , style "font-weight" "bold"
            ] 
            [ text (String.fromChar c) ]) characters status)

view model =
    let
        filledRows = List.concatMap (\(word, status) -> [viewWordRow word status, br [] []] ) model.guesses

        emptyRows = List.concatMap (\word -> 
            [viewWordRow word (List.repeat len Undecided), br [] []]) 
            (List.repeat model.numGuesses (String.repeat len " "))
    in 
    div [ style "display" "grid"
        , style "grid-template-columns" "1fr"
        , style "margin" "20vh 20vh"
        , style "place-items" "center"
        , style "font-family" "monospace"
        , style "font-weight" "bold"
    ] 
        ([p [ style "font-size" "15px" ] [ text (String.concat ["Welcome to Wordle! Guess a/an ", String.fromInt len, "-letter word."]) ]] ++ 
        filledRows ++
        emptyRows ++
        [ input [ 
            style "font-family" "monospace"
            , onInput UpdateWord
            , placeholder "Guess your next word here."
            , value model.currentGuess ] [ ]
        , button [ style "font-family" "monospace"
                 , onClick SubmitGuess
                 , disabled (model.gameOver /= Ongoing) ] 
                 [ text "Submit your guess!" ]
        , p [ style "font-family" "monospace" ] [ text model.error ]
        , div [ style "font-family" "monospace" ] [ 
            text (case model.gameOver of
                Victory ->  
                    "Congratulations, you won!"
                Defeat ->
                    "You have lost! Boo-hoo!" 
                _ ->
                    ""
                )
            ]
        ])
    

main = 
    Browser.sandbox {
        init = init,
        view = view,
        update = update
    }

