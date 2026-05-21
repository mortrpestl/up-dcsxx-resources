module TicTacToe exposing (main)

import Browser
import Html exposing (Html, button, div, text, p)
import Html.Attributes exposing (value, style)
import Html.Events exposing (onClick, onInput, onMouseEnter, onMouseDown, onMouseUp)
import Dict exposing (Dict)

import Array exposing (Array)

n : Int
n = 10

type alias Model = { cells : Dict Int Int, isMouseDown : Bool }

init : Model
init = { cells = Dict.fromList (List.map ((\x -> (x, 0))) (List.range 1 (n*n)) ), isMouseDown = False }

type Msg =
    Toggle Int |
    MouseDown |
    MouseUp

update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle id -> 
            if model.isMouseDown then
                {model | cells = Dict.insert id (1-(Maybe.withDefault 0 (Dict.get id model.cells))) model.cells}
            else
                model
        MouseDown ->
            { model | isMouseDown = True }
        MouseUp ->
            { model | isMouseDown = False }
        

getColor i =
    if (i == 0) then
        "lightgray"
    else
        "darkgray"

generateCells model = 
    div 
    [ style "display" "flex"
    , onMouseDown MouseDown
    , onMouseUp MouseUp
    ] 
    (List.map (\r -> div 
        [ style "display" "grid"
        , style "grid-template-columns" (String.concat ["repeat(", String.fromInt n, "1fr)"])
        , style "justify-content" "space-between"
        ]  
        (List.map (\c -> button
        [ onMouseEnter (Toggle (n*r + c)),
            style "background-color" (getColor (Maybe.withDefault 0 (Dict.get (n*r + c) model.cells))),
            style "height" "10em",
            style "width" "10em"
        ]
        [ text (String.fromInt (n*r + c)) ]
        ) (List.range 0 (n-1)))
    ) (List.range 0 (n-1)))


view model =
    generateCells model

main =
    Browser.sandbox 
    { init = init
    , view = view
    , update = update
    }
