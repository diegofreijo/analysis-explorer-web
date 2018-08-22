-- Test with
--      elm-live Main.elm --output dist/main.js


port module Main exposing (..)

import Html exposing (div, button, text)
import EsgDecoder exposing (decode, JsonESG, JsonEG, JsonNode, JsonEdge)


-- import Html.Events exposing (onClick)
-- import Draw exposing (drawGraph)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



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
    , edges : List Edge
    }


type alias Node =
    { data : NodeData
    , position : NodePosition
    }


type alias NodeData =
    { id : NodeId
    , parent : NodeId
    }


type alias NodeId =
    String


type alias NodePosition =
    { x : Int
    , y : Int
    }


type alias EdgeId =
    String


type alias Edge =
    { data :
        { id : EdgeId
        , source : NodeId
        , target : NodeId
        }
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            case decode of
                Ok jsonEsg ->
                    convertEsg jsonEsg

                Err error ->
                    emptyModel

        -- { nodes =
        --     [ node "A" "M1" 0 0
        --     , node "B" "M1" 0 0
        --     , node "M1" "" 0 0
        --     , node "X" "M2" 0 0
        --     , node "Y" "M2" 0 0
        --     , node "M2" "" 0 0
        --     ]
        -- , edges =
        --     [ edge "AB" "A" "B"
        --     , edge "XY" "X" "Y"
        --     , edge "AX" "A" "X"
        --     , edge "YB" "Y" "B"
        --     , edge "M1M2" "M1" "M2"
        --     , edge "M2X" "M2" "X"
        --     ]
        -- }
    in
        ( model, drawCytoscape model )


convertEsg : JsonESG -> Model
convertEsg { methods } =
    List.foldr 
        (\m acc -> Model 
            (List.append m.nodes acc.nodes)
            (List.append m.edges acc.edges)
        )
        emptyModel
        (List.map convertEg methods)

-- case  of
-- Just m ->
--     case (convertEg m) of
--         ( nodes, edges ) ->
--             Model nodes edges
-- Nothing ->
--     -- TODO: Improve this
--     emptyModel


convertEg : JsonEG -> Model
convertEg { nodes, edges } =
    { nodes = List.map convertNode nodes
    , edges = List.map convertEdge edges
    }


convertNode : JsonNode -> Node
convertNode { id, kind } =
    { data = { id = toString id, parent = "" }
    , position = { x = 0, y = 0 }
    }


convertEdge : JsonEdge -> Edge
convertEdge { origin, destination } =
    let
        source =
            (toString origin)

        target =
            (toString destination)
    in
        { data =
            { id = toString (source ++ target)
            , source = source
            , target = target
            }
        }



-- node : NodeId -> NodeId -> Int -> Int -> Node
-- node id parent x y =
--     { data =
--         { id = id
--         , parent = ""
--         }
--     , position = { x = x, y = y }
--     }
-- edge : EdgeId -> NodeId -> NodeId -> Edge
-- edge id source target =
--     { data =
--         { id = id
--         , source = source
--         , target = target
--         }
--     }


emptyModel : Model
emptyModel =
    { nodes = [], edges = [] }



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- VIEW


view : Model -> Html.Html Msg
view model =
    div []
        [--   button [ onClick Decrement ] [ text "-" ]
         -- , div [] [ text (toString model) ]
         -- , button [ onClick Increment ] [ text "+" ]
        ]



-- PORTS


port drawCytoscape : Model -> Cmd msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
