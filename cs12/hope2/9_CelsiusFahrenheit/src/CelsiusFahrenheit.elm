module CelsiusFahrenheit exposing (main)

import Browser
import Html exposing (Html, div, p, button, br, input, text)
import Html.Attributes exposing (value, style)
import Html.Events exposing (onClick, onInput)


type alias Model = { celsius : Float, fahrenheit : Float}
init =
    { celsius = 100
    , fahrenheit = 212
    }
type Msg
    = MsgUpdateCelsius String
    | MsgUpdateFahrenheit String

roundTo : Int -> Float -> Float
roundTo places value =
    let
        factor = toFloat (10 ^ places)
    in
    toFloat (round (value * factor)) / factor

celsiusToFahrenheit : Float -> Float
celsiusToFahrenheit c =
    roundTo 3 ((9/5) * c + 32)

fahrenheitToCelsius : Float -> Float
fahrenheitToCelsius f =
    roundTo 3 ((5/9) * (f - 32))



update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgUpdateCelsius celsius_ ->
            let
                celsius = String.toFloat celsius_
            in
                case celsius of
                    Nothing -> model
                    Just c -> { model | celsius = c, fahrenheit = celsiusToFahrenheit c }
        MsgUpdateFahrenheit fahrenheit_ ->
            let
                fahrenheit = String.toFloat fahrenheit_
            in
                case fahrenheit of 
                    Nothing -> model 
                    Just f -> { model | celsius = fahrenheitToCelsius f, fahrenheit = f }

view model =
    div [] [
        p [] [ text "Celsius" ],
        input [ onInput (MsgUpdateCelsius), value (String.fromFloat model.celsius) ] [ ],
        br [] [],

        p [] [ text "Fahrenheit" ],
        input [ onInput (MsgUpdateFahrenheit), value (String.fromFloat model.fahrenheit) ] [ ],

        br [] []
    ]


main =
    Browser.sandbox
    { init = init
    , view = view
    , update = update
    }