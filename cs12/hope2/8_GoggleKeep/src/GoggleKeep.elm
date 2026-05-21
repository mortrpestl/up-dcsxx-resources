module GoggleKeep exposing (..)
import Dict exposing (Dict)

import Browser
import Html exposing (Html, div, br, text, p, button, input)
import Html.Events exposing (onInput, onClick, onCheck)
import Html.Attributes exposing (style, value, type_, checked)

type alias Line =
    { toggled : Bool
    , text : String
    }

type alias Box = 
    { currLineId : Int
    , title : String
    , lines : Dict Int Line
    }

type alias Model = 
    { currBoxId : Int
    , boxes : Dict Int Box
    }

type Msg
    = MsgAddLine Int
    | MsgUpdateLine Int Int String
    | MsgAddBox
    | MsgRemoveBox Int
    | MsgRemoveLine Int Int
    | MsgToggleToggled Int Int Bool

init : Model
init =
    { currBoxId = 1
    , boxes = 
        Dict.fromList [(1, 
        { currLineId = 1
        , title = "First Note"
        , lines = Dict.fromList [ (0, newLine) ]
        })]
    }

newBox : Box
newBox =
    { currLineId = 1
    , title = "A Note to Remember"
    , lines = Dict.fromList [ (0, newLine) ]
    }

newLine : Line
newLine = 
    { toggled = False
    , text = ""
    }

update : Msg -> Model -> Model
update msg model =
    case msg of 
        MsgAddLine boxid ->
            { model 
            | boxes = 
                let
                    box : Box
                    box = Maybe.withDefault newBox (Dict.get boxid model.boxes)
                    
                in
                    Dict.insert boxid
                    { box
                    | currLineId = box.currLineId + 1
                    , lines = Dict.insert (box.currLineId + 1) newLine box.lines
                    }
                    model.boxes
            }

        MsgUpdateLine boxid lineid str ->
            { model 
            | boxes = 
                let
                    box : Box
                    box = Maybe.withDefault newBox (Dict.get boxid model.boxes)
                    
                in
                    Dict.insert boxid 
                    { box | lines = Dict.insert lineid { toggled = False, text = str } box.lines }
                    model.boxes
            }

        MsgAddBox ->
            { model 
            | currBoxId = model.currBoxId + 1
            , boxes = Dict.insert (model.currBoxId+1) newBox model.boxes
            }

        MsgRemoveBox boxid ->
            { model 
            | boxes = Dict.remove boxid model.boxes
            }

        MsgRemoveLine boxid lineid ->
            { model 
            | boxes = 
                let
                    box : Box
                    box = Maybe.withDefault newBox (Dict.get boxid model.boxes)
                    
                in
                    Dict.insert boxid { box | lines = Dict.remove lineid box.lines } model.boxes
            }

        MsgToggleToggled boxid lineid checked ->
            { model
            | boxes =
                let
                    box = Maybe.withDefault newBox (Dict.get boxid model.boxes)
                    line = Maybe.withDefault newLine (Dict.get lineid box.lines)
                in
                    Dict.insert boxid
                        { box | lines = Dict.insert lineid { line | toggled = checked } box.lines }
                        model.boxes
            }


    

boxStyle : List (Html.Attribute Msg)
boxStyle = 
    [ style "display" "flex" , style "flex-direction" "column", style "padding" "5%", style "justify-content" "space-around" ]

lineStyle : List (Html.Attribute Msg)
lineStyle = 
    [ style "display" "flex" , style "justify-content" "space-between", style "width" "60%" ]

view : Model -> Html Msg
view model =
    div [ style "display" "flex"
        , style "flex-direction" "column"
        , style "align-items" "center"
        , style "font-family" "monospace" ] 
        [
        div [ style "display" "grid", style "grid-template-columns" "1fr 1fr", style "width" "100%", style "align-items" "center" ] 
        ((List.map ( \(boxid, box) ->
            div
            (boxStyle) 
            ((List.map ( \(lineid, line) ->
                div (lineStyle)
                [ input [ type_ "checkbox", checked line.toggled, onCheck (MsgToggleToggled boxid lineid) ] []
                , input [ value line.text, onInput (MsgUpdateLine boxid lineid) ] []
                , button [ onClick (MsgRemoveLine boxid lineid) ] [ text "Complete Task" ]
                ]
            ) (Dict.toList box.lines) )
            ++ 
            [ button [ onClick (MsgRemoveBox boxid) ] [ text "Remove Box" ]
            , button [ onClick (MsgAddLine boxid) ] [ text "Add Line" ]
            ])

        ) (Dict.toList model.boxes) )
        ),
        button [ onClick MsgAddBox ] [ text "Add" ]
    ]
    

main : Program () Model Msg
main = 
    Browser.sandbox 
        { init = init 
        , view = view 
        , update = update
        }