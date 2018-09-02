module JsonDecoder exposing (esgDecoder, JsonESG, JsonEG, JsonNode, JsonEdge)

import Json.Decode exposing (Decoder, decodeString, field, int, list, map, map2, map3, string, Error)


-- MODEL


type alias JsonESG =
    { methods : List JsonEG }


type alias JsonEG =
    { description : String
    , nodes : List JsonNode
    , edges : List JsonEdge
    }


type alias JsonNode =
    { id : Int
    , kind : Int
    , description : String
    }

type alias JsonEdge =
    { origin : Int
    , destination : Int
    , kind: Int
    }



-- DECODER



esgDecoder : Decoder JsonESG
esgDecoder =
    map JsonESG
        (field "Methods" (list egDecoder))


egDecoder : Decoder JsonEG
egDecoder =
    map3 JsonEG
        (field "Description" string)
        (field "Nodes" (list nodeDecoder))
        (field "Edges" (list edgeDecoder))


nodeDecoder : Decoder JsonNode
nodeDecoder =
    map3 JsonNode
        (field "Id" int)
        (field "Kind" int)
        (field "Description" string)


edgeDecoder : Decoder JsonEdge
edgeDecoder =
    map3 JsonEdge
        (field "Origin" int)
        (field "Destination" int)
        (field "Kind" int)

