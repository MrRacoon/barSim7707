port module Ports exposing (..)

import Json.Encode as Encode
import Json.Decode exposing (decodeValue, succeed, float, map2)


type alias JSMsg =
    { tag : String
    , payload : Encode.Value
    }


port forjs : JSMsg -> Cmd msg


port forElm : (JSMsg -> msg) -> Sub msg


recieve : (ForElmMsg -> msg) -> (String -> msg) -> Sub msg
recieve tagger onError =
    forElm
        (\msg ->
            case msg.tag of
                "NewScreenWidth" ->
                    case decodeValue float msg.payload of
                        Ok result ->
                            tagger <| NewScreenWidth result

                        Err e ->
                            onError e

                "NewScreenHeight" ->
                    case decodeValue float msg.payload of
                        Ok result ->
                            tagger <| NewScreenHeight result

                        Err e ->
                            onError e

                _ ->
                    onError <| "No branch for " ++ msg.tag
        )


type ForElmMsg
    = Unknown
    | NewScreenWidth Float
    | NewScreenHeight Float
