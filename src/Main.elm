module Main exposing (..)

import Browser
import Http exposing (Error(..), Response)
import Html exposing (div, button, text)
import JsonDecoder exposing (esgDecoder, JsonESG, JsonEG, JsonNode, JsonEdge)
import Draw exposing (..)
import RemoteData exposing (WebData, RemoteData(..))


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
    { esg: WebData ESG }

type alias ESG =
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


emptyESG : ESG
emptyESG =
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
        model = { esg = NotAsked }
    in
        ( model, Http.get "http://localhost:50427/api/values" esgDecoder
            |> RemoteData.sendRequest
            |> Cmd.map LoadESG
        )


convertEsg : JsonESG -> ESG
convertEsg { methods } =
    List.foldr
        (\m acc ->
            ESG
                (List.append m.nodes acc.nodes)
                (List.append m.edges acc.edges)
        )
        emptyESG
        (List.indexedMap convertEg methods)


convertEg : Int -> JsonEG -> ESG
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
    = LoadESG (WebData JsonESG)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadESG response ->
            case response of
                Success jsonEsg ->
                    let
                        esg = convertEsg jsonEsg
                    in
                        ( { esg = Success esg }, drawGraph esg )

                Failure e ->
                    ( { esg = Failure e }, Cmd.none)
                
                NotAsked ->
                    ( { esg = NotAsked }, Cmd.none)
                
                Loading ->
                    ( { esg = Loading }, Cmd.none)




-- VIEW


view : Model -> Html.Html Msg
view model =
    case model.esg of
        NotAsked -> text "Initialising"

        Loading -> text "Loading."

        Failure error -> text ("Error! " ++ viewHttpError error)

        Success esg -> esg.nodes
            |> List.length
            |> String.fromInt
            |> (++) "#Nodes: "
            |> text

viewHttpError : Http.Error -> String
viewHttpError error = 
    case error of
        BadUrl url -> "BadUrl: " ++ url
        Timeout -> "Timeout"
        NetworkError -> "NetworkError"
        BadStatus response -> "BadStatus: " ++ response.body
        BadPayload decodingMsg response -> "BadPayload: " ++ decodingMsg ++ ". Response: " ++ response.body


-- PORTS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
