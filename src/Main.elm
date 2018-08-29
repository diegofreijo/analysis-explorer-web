module Main exposing (..)

-- import Basics exposing (..)
-- import List exposing (..)
-- import Maybe exposing (..)
-- import Result exposing (..)
-- import String
-- import Tuple

-- import Debug

-- import Platform exposing ( Program )
-- import Platform.Cmd as Cmd exposing ( Cmd )
-- import Platform.Sub as Sub exposing ( Sub )

import Browser
import Html exposing (div, button, text)
import JsonDecoder exposing (decode, JsonESG, JsonEG, JsonNode, JsonEdge)
import Draw exposing (..)



main : Program () Model Msg
main =
    Browser.element
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


init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            case decode of
                Ok jsonEsg ->
                    convertEsg jsonEsg

                Err error ->
                    -- TODO: Improve this error handling
                    emptyModel
    in
        ( model, drawGraph model )


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
        { id = String.fromInt id
        , name = "Instruction:\n" ++ String.fromInt id
        , parent = Just parent
        }
    , classes = instructionClass
    , position = { x = x, y = row * 100 }
    }


convertEdge : List Node -> JsonEdge -> Edge
convertEdge nodes { origin, destination, kind } =
    let
        source =
            (String.fromInt origin)

        target =
            (String.fromInt destination)
    in
        { data =
            { id = (source ++ target)
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
        |> String.fromInt
        |> (++) "#Nodes: "
        |> text



-- PORTS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
