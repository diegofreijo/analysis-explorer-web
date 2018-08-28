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


type alias Model =
    { nodes : List Node
    , edges : List Edge
    }


type alias Node =
    { data : NodeData
    , classes : Class
    , position : NodePosition
    }


type alias NodeData =
    { id : NodeId
    , name : String
    , parent : Maybe NodeId
    }


type alias Class =
    String


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
    , classes : Class
    }



-- CONSTANTS


emptyModel : Model
emptyModel =
    { nodes = [], edges = [] }


instructionClass : String
instructionClass =
    "instruction"


methodClass : String
methodClass =
    "method"


interproceduralEdgeClass : String
interproceduralEdgeClass =
    "interproceduralEdge"

intraproceduralEdgeClass : String
intraproceduralEdgeClass =
    "intraproceduralEdge"



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        model =
            case decode of
                Ok jsonEsg ->
                    convertEsg jsonEsg

                Err error ->
                    -- TODO: Improve this error handling
                    emptyModel
    in
        ( model, drawCytoscape model )


convertEsg : JsonESG -> Model
convertEsg { methods } =
    List.foldr
        (\m acc ->
            Model
                (List.append m.nodes acc.nodes)
                (List.append m.edges acc.edges)
        )
        emptyModel
        (List.indexedMap convertEg methods)


convertEg : Int -> JsonEG -> Model
convertEg column { name, nodes, edges } =
    let
        x =
            column * 250

        methodNode =
            createMethodNode name name x

        newNodes =
            methodNode
                :: List.indexedMap (convertInstructionNode name x) nodes
    in
        { nodes = newNodes
        , edges = List.map (convertEdge newNodes) edges
        }


createMethodNode : String -> NodeId -> Int -> Node
createMethodNode name id x =
    { data =
        { id = id
        , name = "Method:\n" ++ name
        , parent = Nothing
        }
    , classes = methodClass
    , position = { x = x, y = 0 }
    }


convertInstructionNode : NodeId -> Int -> Int -> JsonNode -> Node
convertInstructionNode parent x row { id, kind } =
    { data =
        { id = toString id
        , name = "Instruction:\n" ++ toString id
        , parent = Just parent
        }
    , classes = instructionClass
    , position = { x = x, y = row * 100 }
    }


convertEdge : List Node -> JsonEdge -> Edge
convertEdge nodes { origin, destination, kind } =
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
        , classes = 
            case kind of
                0 -> interproceduralEdgeClass
                _ -> intraproceduralEdgeClass
        }



-- HELPERS
-- wnodesWithParents : List Node ->  -> ()
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
    model.nodes
        |> List.length
        |> toString
        |> (++) "#Nodes: "
        |> text



-- PORTS


port drawCytoscape : Model -> Cmd msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
