module Connections exposing (main)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- MODEL

type alias Model =
    { groups : Dict Int (List String)
    , selected : List ( Int, String )
    , attempts : List (List String)
    , groupStatus : Dict Int Status
    , message : String
    }

type Status
    = Complete
    | Incomplete


init : Model
init =
    { groups =
        Dict.fromList
            [ ( 1, [ "cipher", "encounters", "firecracker", "blackout" ] )
            , ( 2, [ "cicada", "television", "firework", "platypus" ] )
            , ( 3, [ "card", "plate", "firearm", "fingerprint" ] )
            , ( 4, [ "chalk", "matrix", "coast", "blueprint" ] )
            ]
    , selected = []
    , attempts = []
    , groupStatus =
        Dict.fromList
            [ ( 1, Incomplete )
            , ( 2, Incomplete )
            , ( 3, Incomplete )
            , ( 4, Incomplete )
            ]
    , message = "Select four words."
    }



type Msg
    = ToggleTile ( Int, String )
    | Submit
    | Deselect


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleTile tile ->
            let
                newSelected =
                    if List.member tile model.selected then
                        List.filter (\t -> t /= tile) model.selected
                    else if List.length model.selected < 4 then
                        tile :: model.selected
                    else
                        model.selected
            in
            { model | selected = newSelected }

        Deselect ->
            { model | selected = [] }

        Submit ->
            if List.length model.selected /= 4 then
                { model | message = "Select exactly 4 tiles." }
            else
                let
                    ids =
                        List.map Tuple.first model.selected

                    allSame =
                        case ids of
                            first :: rest ->
                                List.all (\x -> x == first) rest
                            [] ->
                                False
                in
                if allSame then
                    let
                        groupId =
                            Maybe.withDefault 0 (List.head ids)

                        newStatus =
                            Dict.insert groupId Complete model.groupStatus

                        allDone =
                            Dict.values newStatus |> List.all (\s -> s == Complete)
                    in
                    { model
                        | groupStatus = newStatus
                        , selected = []
                        , attempts = List.map Tuple.second model.selected :: model.attempts
                        , message = if allDone then "You win!" else "Correct!"
                    }
                else
                    { model
                        | selected = []
                        , attempts = List.map Tuple.second model.selected :: model.attempts
                        , message = "Wrong!"
                    }


groupColors : Dict Int String
groupColors =
    Dict.fromList
        [ ( 1, "#f9df6d" )
        , ( 2, "#a0c35a" )
        , ( 3, "#b0c4ef" )
        , ( 4, "#ba81c5" )
        ]


pairUp : Dict Int (List String) -> List ( Int, String )
pairUp groups =
    Dict.toList groups
        |> List.concatMap (\( id, words ) -> List.map (\w -> ( id, w )) words)


chunksOf : Int -> List a -> List (List a)
chunksOf n lst =
    case lst of
        [] -> []
        _  -> List.take n lst :: chunksOf n (List.drop n lst)


viewTile : Model -> ( Int, String ) -> Html Msg
viewTile model ( id, word ) =
    let
        sel = List.member ( id, word ) model.selected
        done = Dict.get id model.groupStatus == Just Complete
        bg =
            if done then Maybe.withDefault "#ccc" (Dict.get id groupColors)
            else if sel then "#333"
            else "#efefe6"
        fg = if sel && not done then "#fff" else "#333"
    in
    div
        [ style "flex" "1"
        , style "padding" "20px 4px"
        , style "background" bg
        , style "color" fg
        , style "border-radius" "8px"
        , style "font-size" "13px"
        , style "font-weight" "bold"
        , style "text-transform" "uppercase"
        , style "cursor" "pointer"
        , style "text-align" "center"
        , style "user-select" "none"
        , onClick (ToggleTile ( id, word ))
        ]
        [ text word ]


viewGrid : Model -> Html Msg
viewGrid model =
    let
        pairs = pairUp model.groups
        rows  = chunksOf 4 pairs
    in
    div [] (List.map (\row ->
        div [ style "display" "flex", style "gap" "8px", style "margin-bottom" "8px" ]
            (List.map (viewTile model) row)
    ) rows)


view : Model -> Html Msg
view model =
    div
        [ style "font-family" "sans-serif"
        , style "max-width" "520px"
        , style "margin" "40px auto"
        , style "text-align" "center"
        ]
        [ div [ style "font-size" "24px", style "font-weight" "bold", style "margin-bottom" "8px" ]
            [ text "Connections" ]
        , div [ style "margin-bottom" "16px", style "color" "#555", style "font-size" "14px" ]
            [ text model.message ]
        , viewGrid model
        , div [ style "margin-top" "16px", style "display" "flex", style "gap" "8px", style "justify-content" "center" ]
            [ button [ onClick Deselect ] [ text "Deselect All" ]
            , button [ onClick Submit ]   [ text "Submit" ]
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }