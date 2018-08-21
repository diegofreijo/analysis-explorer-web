-- Test with
--      elm-live Main.elm --output dist/main.js


port module Main exposing (..)

import Html exposing (div, button, text)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL

type alias Model = { 
        count: Int,
        last: String
    }


init : ( Model, Cmd Msg )
init =
    updateCounter 0 "init"



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg { count, last } =
    case msg of
        Increment ->
            updateCounter (count + 1) "increment"

        Decrement ->
            updateCounter (count - 1) "decrement"


updateCounter : Int -> String -> ( Model, Cmd msg )
updateCounter count last =
    let
        model = { count = count, last = last }
    in
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

port output : Model -> Cmd msg

port input : (Model -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    input (\x -> Increment)

