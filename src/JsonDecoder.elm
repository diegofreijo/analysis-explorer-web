module JsonDecoder exposing (decode, JsonESG, JsonEG, JsonNode, JsonEdge)

import Json.Decode exposing (Decoder, decodeString, field, int, list, map, map2, map3, string)


-- MODEL


type alias JsonESG =
    { methods : List JsonEG }


type alias JsonEG =
    { name : String
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


decode : Result String JsonESG
decode =
    decodeString esgDecoder jsonStringTest


esgDecoder : Decoder JsonESG
esgDecoder =
    map JsonESG
        (field "Methods" (list egDecoder))


egDecoder : Decoder JsonEG
egDecoder =
    map3 JsonEG
        (field "Name" string)
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


jsonStringTest : String
jsonStringTest =
    """
{
    "Methods": [
        {
            "Name": "M1",
            "Nodes": [
                {
                    "Id": 0,
                    "Kind": 0,
                    "Description": "Method: Main"
                },
                {
                    "Id": 1,
                    "Kind": 1,
                    "Description": "Method: Main"
                },
                {
                    "Id": 2,
                    "Kind": 2,
                    "Description": "L_0000:  nop;"
                },
                {
                    "Id": 3,
                    "Kind": 2,
                    "Description": "L_0001:  $s0 = new IDETests;"
                },
                {
                    "Id": 4,
                    "Kind": 3,
                    "Description": "Call: .ctor"
                },
                {
                    "Id": 5,
                    "Kind": 2,
                    "Description": "L_0001:  $s0 = $s0;"
                },
                {
                    "Id": 6,
                    "Kind": 2,
                    "Description": "L_0006:  ide = $s0;"
                },
                {
                    "Id": 7,
                    "Kind": 2,
                    "Description": "L_0007:  $s0 = ide;"
                },
                {
                    "Id": 8,
                    "Kind": 3,
                    "Description": "Call: CallingLinear"
                },
                {
                    "Id": 9,
                    "Kind": 2,
                    "Description": "L_000E:  return;"
                },
                {
                    "Id": 43,
                    "Kind": 4,
                    "Description": "Return Call: .ctor"
                },
                {
                    "Id": 44,
                    "Kind": 4,
                    "Description": "Return Call: CallingLinear"
                }
            ],
            "Edges": [
                {
                    "Kind": 1,
                    "Origin": 2,
                    "Destination": 3
                },
                {
                    "Kind": 1,
                    "Origin": 3,
                    "Destination": 4
                },
                {
                    "Kind": 1,
                    "Origin": 4,
                    "Destination": 43
                },
                {
                    "Kind": 1,
                    "Origin": 5,
                    "Destination": 6
                },
                {
                    "Kind": 1,
                    "Origin": 6,
                    "Destination": 7
                },
                {
                    "Kind": 1,
                    "Origin": 7,
                    "Destination": 8
                },
                {
                    "Kind": 1,
                    "Origin": 8,
                    "Destination": 44
                },
                {
                    "Kind": 1,
                    "Origin": 0,
                    "Destination": 2
                },
                {
                    "Kind": 1,
                    "Origin": 9,
                    "Destination": 1
                },
                {
                    "Kind": 1,
                    "Origin": 43,
                    "Destination": 5
                },
                {
                    "Kind": 0,
                    "Origin": 11,
                    "Destination": 43
                },
                {
                    "Kind": 1,
                    "Origin": 44,
                    "Destination": 9
                },
                {
                    "Kind": 0,
                    "Origin": 17,
                    "Destination": 44
                }
            ]
        },
        {
            "Name": "M2",
            "Nodes": [
                {
                    "Id": 10,
                    "Kind": 0,
                    "Description": "Method: .ctor"
                },
                {
                    "Id": 11,
                    "Kind": 1,
                    "Description": "Method: .ctor"
                },
                {
                    "Id": 12,
                    "Kind": 2,
                    "Description": "L_0000:  $s0 = this;"
                },
                {
                    "Id": 13,
                    "Kind": 3,
                    "Description": "Call: .ctor"
                },
                {
                    "Id": 14,
                    "Kind": 2,
                    "Description": "L_0006:  nop;"
                },
                {
                    "Id": 15,
                    "Kind": 2,
                    "Description": "L_0007:  return;"
                },
                {
                    "Id": 45,
                    "Kind": 4,
                    "Description": "Return Call: .ctor"
                }
            ],
            "Edges": [
                {
                    "Kind": 1,
                    "Origin": 12,
                    "Destination": 13
                },
                {
                    "Kind": 1,
                    "Origin": 13,
                    "Destination": 45
                },
                {
                    "Kind": 1,
                    "Origin": 14,
                    "Destination": 15
                },
                {
                    "Kind": 1,
                    "Origin": 10,
                    "Destination": 12
                },
                {
                    "Kind": 1,
                    "Origin": 15,
                    "Destination": 11
                },
                {
                    "Kind": 1,
                    "Origin": 45,
                    "Destination": 14
                },
                {
                    "Kind": 0,
                    "Origin": 11,
                    "Destination": 45
                }
            ]
        },
        {
            "Name": "M3",
            "Nodes": [
                {
                    "Id": 16,
                    "Kind": 0,
                    "Description": "Method: CallingLinear"
                },
                {
                    "Id": 17,
                    "Kind": 1,
                    "Description": "Method: CallingLinear"
                },
                {
                    "Id": 18,
                    "Kind": 2,
                    "Description": "L_0000:  nop;"
                },
                {
                    "Id": 19,
                    "Kind": 2,
                    "Description": "L_0001:  $s0 = 2;"
                },
                {
                    "Id": 20,
                    "Kind": 2,
                    "Description": "L_0002:  d = $s0;"
                },
                {
                    "Id": 21,
                    "Kind": 2,
                    "Description": "L_0003:  $s0 = this;"
                },
                {
                    "Id": 22,
                    "Kind": 3,
                    "Description": "Call: Linear"
                },
                {
                    "Id": 23,
                    "Kind": 2,
                    "Description": "L_0009:  e = $s0;"
                },
                {
                    "Id": 24,
                    "Kind": 2,
                    "Description": "L_000A:  $s0 = d;"
                },
                {
                    "Id": 25,
                    "Kind": 2,
                    "Description": "L_000B:  $s1 = e;"
                },
                {
                    "Id": 26,
                    "Kind": 2,
                    "Description": "L_000C:  $s0 = $s0 + $s1;"
                },
                {
                    "Id": 27,
                    "Kind": 2,
                    "Description": "L_000D:  local_2 = $s0;"
                },
                {
                    "Id": 28,
                    "Kind": 2,
                    "Description": "L_000E:  goto L_0010;"
                },
                {
                    "Id": 29,
                    "Kind": 2,
                    "Description": "L_0010:  $s0 = local_2;"
                },
                {
                    "Id": 30,
                    "Kind": 2,
                    "Description": "L_0011:  return $s0;"
                },
                {
                    "Id": 46,
                    "Kind": 4,
                    "Description": "Return Call: Linear"
                }
            ],
            "Edges": [
                {
                    "Kind": 1,
                    "Origin": 18,
                    "Destination": 19
                },
                {
                    "Kind": 1,
                    "Origin": 19,
                    "Destination": 20
                },
                {
                    "Kind": 1,
                    "Origin": 20,
                    "Destination": 21
                },
                {
                    "Kind": 1,
                    "Origin": 21,
                    "Destination": 22
                },
                {
                    "Kind": 1,
                    "Origin": 22,
                    "Destination": 46
                },
                {
                    "Kind": 1,
                    "Origin": 23,
                    "Destination": 24
                },
                {
                    "Kind": 1,
                    "Origin": 24,
                    "Destination": 25
                },
                {
                    "Kind": 1,
                    "Origin": 25,
                    "Destination": 26
                },
                {
                    "Kind": 1,
                    "Origin": 26,
                    "Destination": 27
                },
                {
                    "Kind": 1,
                    "Origin": 27,
                    "Destination": 28
                },
                {
                    "Kind": 1,
                    "Origin": 28,
                    "Destination": 29
                },
                {
                    "Kind": 1,
                    "Origin": 29,
                    "Destination": 30
                },
                {
                    "Kind": 1,
                    "Origin": 16,
                    "Destination": 18
                },
                {
                    "Kind": 1,
                    "Origin": 30,
                    "Destination": 17
                },
                {
                    "Kind": 1,
                    "Origin": 46,
                    "Destination": 23
                },
                {
                    "Kind": 0,
                    "Origin": 32,
                    "Destination": 46
                }
            ]
        },
        {
            "Name": "M4",
            "Nodes": [
                {
                    "Id": 31,
                    "Kind": 0,
                    "Description": "Method: Linear"
                },
                {
                    "Id": 32,
                    "Kind": 1,
                    "Description": "Method: Linear"
                },
                {
                    "Id": 33,
                    "Kind": 2,
                    "Description": "L_0000:  nop;"
                },
                {
                    "Id": 34,
                    "Kind": 2,
                    "Description": "L_0001:  $s0 = 5;"
                },
                {
                    "Id": 35,
                    "Kind": 2,
                    "Description": "L_0002:  a = $s0;"
                },
                {
                    "Id": 36,
                    "Kind": 2,
                    "Description": "L_0003:  $s0 = a;"
                },
                {
                    "Id": 37,
                    "Kind": 2,
                    "Description": "L_0004:  $s1 = 2;"
                },
                {
                    "Id": 38,
                    "Kind": 2,
                    "Description": "L_0005:  $s0 = $s0 + $s1;"
                },
                {
                    "Id": 39,
                    "Kind": 2,
                    "Description": "L_0006:  local_1 = $s0;"
                },
                {
                    "Id": 40,
                    "Kind": 2,
                    "Description": "L_0007:  goto L_0009;"
                },
                {
                    "Id": 41,
                    "Kind": 2,
                    "Description": "L_0009:  $s0 = local_1;"
                },
                {
                    "Id": 42,
                    "Kind": 2,
                    "Description": "L_000A:  return $s0;"
                }
            ],
            "Edges": [
                {
                    "Kind": 1,
                    "Origin": 33,
                    "Destination": 34
                },
                {
                    "Kind": 1,
                    "Origin": 34,
                    "Destination": 35
                },
                {
                    "Kind": 1,
                    "Origin": 35,
                    "Destination": 36
                },
                {
                    "Kind": 1,
                    "Origin": 36,
                    "Destination": 37
                },
                {
                    "Kind": 1,
                    "Origin": 37,
                    "Destination": 38
                },
                {
                    "Kind": 1,
                    "Origin": 38,
                    "Destination": 39
                },
                {
                    "Kind": 1,
                    "Origin": 39,
                    "Destination": 40
                },
                {
                    "Kind": 1,
                    "Origin": 40,
                    "Destination": 41
                },
                {
                    "Kind": 1,
                    "Origin": 41,
                    "Destination": 42
                },
                {
                    "Kind": 1,
                    "Origin": 31,
                    "Destination": 33
                },
                {
                    "Kind": 1,
                    "Origin": 42,
                    "Destination": 32
                }
            ]
        }
    ]
}
    """
