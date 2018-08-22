module EsgDecoder exposing (decode)

import Json.Decode exposing (Decoder, decodeString, field, int, list, map, map2)


-- import Json.Decode.Pipeline exposing (required, optional, hardcoded)
-- MODEL


type alias JsonESG =
    { methods : List JsonEG }


type alias JsonEG =
    { nodes : List JsonNode }


type alias JsonNode =
    { id : Int, kind : Int }



-- DECODER

decode : Result String JsonESG
decode =
    decodeString esgDecoder jsonStringTest


esgDecoder : Decoder JsonESG
esgDecoder =
    map JsonESG
        (field "Methods" (list egDecoder))


egDecoder : Decoder JsonEG
egDecoder =
    map JsonEG
        (field "Nodes" (list nodeDecoder))


nodeDecoder : Decoder JsonNode
nodeDecoder =
    map2 JsonNode
        (field "Id" int)
        (field "Kind" int)



-- decodeESG : Json.Decode.Decoder ESG
-- decodeESG =
--     Json.Decode.map ESG
--         (field "methods" Json.Decode.list decodeComplexType)
-- encodeESG : ESG -> Json.Encode.Value
-- encodeESG record =
--     Json.Encode.object
--         [ ( "methods", Json.Encode.list <| List.map encodeComplexType <| record.methods )
--         ]


jsonStringTest : String
jsonStringTest =
    """
    {
    "Methods": [
        {
            "Nodes": [
                {
                    "Id": 0,
                    "Kind": 0
                },
                {
                    "Id": 1,
                    "Kind": 0
                },
                {
                    "Id": 2,
                    "Kind": 1
                },
                {
                    "Id": 3,
                    "Kind": 1
                },
                {
                    "Id": 4,
                    "Kind": 2
                },
                {
                    "Id": 5,
                    "Kind": 1
                },
                {
                    "Id": 6,
                    "Kind": 1
                },
                {
                    "Id": 7,
                    "Kind": 1
                },
                {
                    "Id": 8,
                    "Kind": 2
                },
                {
                    "Id": 9,
                    "Kind": 1
                },
                {
                    "Id": 43,
                    "Kind": 3
                },
                {
                    "Id": 44,
                    "Kind": 3
                }
            ],
            "Edges": [
                {
                    "Origin": 0,
                    "Destination": 2
                },
                {
                    "Origin": 2,
                    "Destination": 3
                },
                {
                    "Origin": 3,
                    "Destination": 4
                },
                {
                    "Origin": 4,
                    "Destination": 43
                },
                {
                    "Origin": 4,
                    "Destination": 10
                },
                {
                    "Origin": 5,
                    "Destination": 6
                },
                {
                    "Origin": 6,
                    "Destination": 7
                },
                {
                    "Origin": 7,
                    "Destination": 8
                },
                {
                    "Origin": 8,
                    "Destination": 44
                },
                {
                    "Origin": 8,
                    "Destination": 16
                },
                {
                    "Origin": 9,
                    "Destination": 1
                },
                {
                    "Origin": 43,
                    "Destination": 5
                },
                {
                    "Origin": 44,
                    "Destination": 9
                }
            ]
        },
        {
            "Nodes": [
                {
                    "Id": 10,
                    "Kind": 0
                },
                {
                    "Id": 11,
                    "Kind": 0
                },
                {
                    "Id": 12,
                    "Kind": 1
                },
                {
                    "Id": 13,
                    "Kind": 2
                },
                {
                    "Id": 14,
                    "Kind": 1
                },
                {
                    "Id": 15,
                    "Kind": 1
                },
                {
                    "Id": 45,
                    "Kind": 3
                }
            ],
            "Edges": [
                {
                    "Origin": 10,
                    "Destination": 12
                },
                {
                    "Origin": 11,
                    "Destination": 43
                },
                {
                    "Origin": 11,
                    "Destination": 45
                },
                {
                    "Origin": 12,
                    "Destination": 13
                },
                {
                    "Origin": 13,
                    "Destination": 45
                },
                {
                    "Origin": 13,
                    "Destination": 10
                },
                {
                    "Origin": 14,
                    "Destination": 15
                },
                {
                    "Origin": 15,
                    "Destination": 11
                },
                {
                    "Origin": 45,
                    "Destination": 14
                }
            ]
        },
        {
            "Nodes": [
                {
                    "Id": 16,
                    "Kind": 0
                },
                {
                    "Id": 17,
                    "Kind": 0
                },
                {
                    "Id": 18,
                    "Kind": 1
                },
                {
                    "Id": 19,
                    "Kind": 1
                },
                {
                    "Id": 20,
                    "Kind": 1
                },
                {
                    "Id": 21,
                    "Kind": 1
                },
                {
                    "Id": 22,
                    "Kind": 2
                },
                {
                    "Id": 23,
                    "Kind": 1
                },
                {
                    "Id": 24,
                    "Kind": 1
                },
                {
                    "Id": 25,
                    "Kind": 1
                },
                {
                    "Id": 26,
                    "Kind": 1
                },
                {
                    "Id": 27,
                    "Kind": 1
                },
                {
                    "Id": 28,
                    "Kind": 1
                },
                {
                    "Id": 29,
                    "Kind": 1
                },
                {
                    "Id": 30,
                    "Kind": 1
                },
                {
                    "Id": 46,
                    "Kind": 3
                }
            ],
            "Edges": [
                {
                    "Origin": 16,
                    "Destination": 18
                },
                {
                    "Origin": 17,
                    "Destination": 44
                },
                {
                    "Origin": 18,
                    "Destination": 19
                },
                {
                    "Origin": 19,
                    "Destination": 20
                },
                {
                    "Origin": 20,
                    "Destination": 21
                },
                {
                    "Origin": 21,
                    "Destination": 22
                },
                {
                    "Origin": 22,
                    "Destination": 46
                },
                {
                    "Origin": 22,
                    "Destination": 31
                },
                {
                    "Origin": 23,
                    "Destination": 24
                },
                {
                    "Origin": 24,
                    "Destination": 25
                },
                {
                    "Origin": 25,
                    "Destination": 26
                },
                {
                    "Origin": 26,
                    "Destination": 27
                },
                {
                    "Origin": 27,
                    "Destination": 28
                },
                {
                    "Origin": 28,
                    "Destination": 29
                },
                {
                    "Origin": 29,
                    "Destination": 30
                },
                {
                    "Origin": 30,
                    "Destination": 17
                },
                {
                    "Origin": 46,
                    "Destination": 23
                }
            ]
        },
        {
            "Nodes": [
                {
                    "Id": 31,
                    "Kind": 0
                },
                {
                    "Id": 32,
                    "Kind": 0
                },
                {
                    "Id": 33,
                    "Kind": 1
                },
                {
                    "Id": 34,
                    "Kind": 1
                },
                {
                    "Id": 35,
                    "Kind": 1
                },
                {
                    "Id": 36,
                    "Kind": 1
                },
                {
                    "Id": 37,
                    "Kind": 1
                },
                {
                    "Id": 38,
                    "Kind": 1
                },
                {
                    "Id": 39,
                    "Kind": 1
                },
                {
                    "Id": 40,
                    "Kind": 1
                },
                {
                    "Id": 41,
                    "Kind": 1
                },
                {
                    "Id": 42,
                    "Kind": 1
                }
            ],
            "Edges": [
                {
                    "Origin": 31,
                    "Destination": 33
                },
                {
                    "Origin": 32,
                    "Destination": 46
                },
                {
                    "Origin": 33,
                    "Destination": 34
                },
                {
                    "Origin": 34,
                    "Destination": 35
                },
                {
                    "Origin": 35,
                    "Destination": 36
                },
                {
                    "Origin": 36,
                    "Destination": 37
                },
                {
                    "Origin": 37,
                    "Destination": 38
                },
                {
                    "Origin": 38,
                    "Destination": 39
                },
                {
                    "Origin": 39,
                    "Destination": 40
                },
                {
                    "Origin": 40,
                    "Destination": 41
                },
                {
                    "Origin": 41,
                    "Destination": 42
                },
                {
                    "Origin": 42,
                    "Destination": 32
                }
            ]
        }
    ]
}

"""
