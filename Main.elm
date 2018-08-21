-- Test with
--      elm-live Main.elm --output dist/main.js


port module Main exposing (..)

import Html exposing (div, button, text)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL
-- elements: {
--     nodes: [
--         { data: { id: 'a', parent: 'b' }, position: { x: 215, y: 85 } },
--         { data: { id: 'b' } },
--         { data: { id: 'c', parent: 'b' }, position: { x: 300, y: 85 } },
--         { data: { id: 'd' }, position: { x: 215, y: 175 } },
--         { data: { id: 'e' } },
--         { data: { id: 'f', parent: 'e' }, position: { x: 300, y: 175 } }
--     ],
--     edges: [
--         { data: { id: 'ad', source: 'a', target: 'd' } },
--         { data: { id: 'eb', source: 'e', target: 'b' } }
--     ]
-- }


type alias Model =
    { nodes : List Node

    -- edges: List Edge
    }


type alias Node =
    { data : NodeData
    , position : NodePosition
    }


type alias NodeData =
    { id : NodeId
    , parent : NodeId
    }

type alias NodeId = String

type alias NodePosition =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { nodes =
                [ 
                    node "A" "C" 0 0,
                    node "B" "C" 50 0,
                    node "C" "" 0 0
                ]
            }
    in
        ( model, drawGraph model )


node : NodeId -> NodeId -> Int -> Int -> Node
node id parent x y =
    {
        data = { id = id, parent = parent }, 
        position = { x = x, y = y }
    }

-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- case msg of
--     Increment ->
--         updateCounter (count + 1) "increment"
--     Decrement ->
--         updateCounter (count - 1) "decrement"
-- updateCounter : Int -> String -> ( Model, Cmd msg )
-- updateCounter count last =
--     let
--         model = { count = count, last = last }
--     in
--         ( model, output model )
-- VIEW


view : Model -> Html.Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]



-- PORTS


port drawGraph : Model -> Cmd msg


port input : (Model -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    input (\x -> Increment)
