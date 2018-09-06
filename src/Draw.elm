port module Draw exposing (drawGraph, Graph)


-- MODEL


type alias Graph =
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


methodClass : String
methodClass =
    "method"


interproceduralEdgeClass : String
interproceduralEdgeClass =
    "interproceduralEdge"


intraproceduralEdgeClass : String
intraproceduralEdgeClass =
    "intraproceduralEdge"



-- API
 
-- instructionNode : String ->  String -> Maybe Node -> Int -> Int -> Node
-- instructionNode id name parent x y = 
--     { data =
--         { id = id
--         , name = "Instruction: " ++ id
--         , parent = Maybe.map (\p -> p.data.id) parent
--         }
--     , classes = "node instruction"
--     , position = { x = x, y = y }
--     }


-- graph : List Node -> List Edge -> Graph
-- graph nodes edges = 
--     { nodes = nodes
--     , edges = edges
--     }


drawGraph : Graph -> Cmd msg
drawGraph = drawCytoscape



-- PORTS


port drawCytoscape : Graph -> Cmd msg
