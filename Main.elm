-- Test with
--      elm-live Main.elm --output main.js


port module Main exposing (..)

import Html exposing (div, button, text)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL

type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    updateCounter 0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            updateCounter (model + 1)

        Decrement ->
            updateCounter (model - 1)


updateCounter : Model -> ( Model, Cmd msg )
updateCounter model =
    ( model, output model )



-- VIEW


view : Model -> Html.Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]



-- PORTS

port output : Int -> Cmd msg


port input : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    input (\x -> Increment)

