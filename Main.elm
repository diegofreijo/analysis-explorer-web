module Main exposing (..)

import Html exposing (div, button, text)
import JsonDecoder exposing (decode, JsonESG, JsonEG, JsonNode, JsonEdge)
import Draw exposing (..)


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


type alias Model =
    {}



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        graph =
            case decode of
                Ok jsonEsg ->
                    convertEsg jsonEsg

                Err error ->
                    -- TODO: Improve this error handling
                    Draw.graph [] []
    in
        ( {}, Draw.drawGraph graph )


convertEsg : JsonESG -> Draw.Graph
convertEsg { methods } =
    let
        nodes =
            (Draw.instructionNode "1" "I1" Nothing 0 0)
                :: (Draw.instructionNode "2" "I2" Nothing 0 100)
                :: []

        edges =
            []
    in
        Draw.graph nodes edges



-- List.foldr
--     (\m acc ->
--         Model
--             (List.append m.nodes acc.nodes)
--             (List.append m.edges acc.edges)
--     )
--     emptyModel
--     (List.indexedMap convertEg methods)


-- convertEg : Int -> JsonEG -> Model
-- convertEg column { name, nodes, edges } =
--     let
--         x =
--             column * 250

--         methodNode =
--             createMethodNode name name x

--         newNodes =
--             methodNode
--                 :: List.indexedMap (convertInstructionNode name x) nodes
--     in
--         { nodes = newNodes
--         , edges = List.map (convertEdge newNodes) edges
--         }


-- createMethodNode : String -> NodeId -> Int -> Node
-- createMethodNode name id x =
--     { data =
--         { id = id
--         , name = "Method:\n" ++ name
--         , parent = Nothing
--         }
--     , classes = methodClass
--     , position = { x = x, y = 0 }
--     }



-- convertInstructionNode : NodeId -> Int -> Int -> JsonNode -> Node
-- convertInstructionNode parent x row { id, kind } =
--     { data =
--         { id = toString id
--         , name = "Instruction:\n" ++ toString id
--         , parent = Just parent
--         }
--     , classes = "node " ++
--         case kind of
--             0 ->
--                 "entryNode"
--             1 ->
--                 "exitNode"
--             _ ->
--                 instructionClass
--     , position = { x = x, y = row * 100 }
--     }


-- convertEdge : List Node -> JsonEdge -> Edge
-- convertEdge nodes { origin, destination, kind } =
--     let
--         source =
--             (toString origin)

--         target =
--             (toString destination)
--     in
--         { data =
--             { id = toString (source ++ target)
--             , source = source
--             , target = target
--             }
--         , classes =
--             case kind of
--                 0 ->
--                     interproceduralEdgeClass

--                 _ ->
--                     intraproceduralEdgeClass
--         }



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
    text ":)"
    -- model.nodes
    --     |> List.length
    --     |> toString
    --     |> (++) "#Nodes: "
    --     |> text



-- PORTS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
