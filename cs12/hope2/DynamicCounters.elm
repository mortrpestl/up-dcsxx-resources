module DynamicCounters exposing (main)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, text, p, span, input, br)
import Html.Attributes exposing (id, style)
import Html.Events exposing (onClick, onInput)

type Msg
    = MsgNewCounter
    | MsgIncrement Int
    | MsgDecrement Int
    | MsgReset Int
    | MsgDelete Int

type alias CounterInfo =
    { cid: Int
    , count: Int
    }

type alias Model = 
    { nextId : Int
    , counters : Dict Int CounterInfo
    }

init: Model
init = { nextId = 0, counters = Dict.empty }

defaultInfo : CounterInfo
defaultInfo = {cid = -1, count = 0}

viewCounter : CounterInfo -> Html Msg
viewCounter info =
    div [ id (String.fromInt info.cid)
        , style "border" "1px solid black"
        , style "padding" "3px"]

        [ button [onClick (MsgIncrement info.cid)] [text "+"]
        , span [] [text (" " ++ String.fromInt info.count ++ " ")]
        , button [onClick (MsgDecrement info.cid)] [text "-"]
        , br [] []
        , button [onClick (MsgReset info.cid)] [text "Reset"]
        , button [onClick (MsgDelete info.cid)] [text "Delete"]
        ]


update: Msg -> Model -> Model
update msg model =
    case msg of
        MsgNewCounter ->
            { model
            | nextId = model.nextId + 1
            , counters = (Dict.insert model.nextId {cid = model.nextId, count = 0} model.counters)
            }
        MsgIncrement cid ->
            let
                cinfo = (Dict.get cid model.counters) |> Maybe.withDefault defaultInfo
            in
            { model
            | counters = (Dict.insert cid {cinfo | count = cinfo.count + 1} model.counters)
            }
        MsgDecrement cid ->
            let
                cinfo = (Dict.get cid model.counters) |> Maybe.withDefault defaultInfo
            in
            { model
            | counters = (Dict.insert cid {cinfo | count = cinfo.count - 1} model.counters)
            }
        MsgReset cid ->
            let
                cinfo = (Dict.get cid model.counters) |> Maybe.withDefault defaultInfo
            in
            { model
            | counters = (Dict.insert cid {cinfo | count = 0} model.counters)
            }
        MsgDelete cid ->
            { model
            | counters = (Dict.remove cid model.counters)
            }


view : Model -> Html Msg
view model =
    div []
        ( (::)
        (button [onClick MsgNewCounter] [text "New counter"])
        (List.map viewCounter (Dict.values model.counters))
        )


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
