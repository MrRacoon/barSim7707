module Stats.View exposing (..)

import Svg exposing (Svg, g, rect, text_, text)
import Stats.Types exposing (Model)
import Animation
import Dict
import List.Extra as ListE
import Svg.Attributes
    exposing
        ( fill
        , fontSize
        , fontFamily
        , height
        , width
        , x
        , y
        )


view : Model -> Svg msg
view model =
    let
        counts =
            model.last
                |> List.concat
                |> List.sort
                |> ListE.group
                |> List.sortBy List.length
                |> List.reverse
                |> List.take 10
                |> List.map
                    (\ls ->
                        let
                            l =
                                Maybe.withDefault 0 (List.head ls)

                            all =
                                Maybe.withDefault 0 (Dict.get l model.history)
                        in
                            ( l
                            , List.length ls
                            , all
                            )
                    )
                |> List.filter (\( l, c, a ) -> c > 1)
    in
        g (Animation.render model.g)
            ([ rect
                [ fill "black"
                , width "100%"
                , height "100%"
                , x "0"
                , y "0"
                ]
                []
             , text_
                [ fontSize "30px"
                , fontFamily "Verdana"
                , x "30px"
                , y "30px"
                , fill "white"
                ]
                [ text "Most Common Numbers (Recent / All Time)" ]
             ]
                ++ (List.indexedMap
                        (\i ( num, count, all ) ->
                            (text_
                                [ fontSize "30px"
                                , fontFamily "Verdana"
                                , x <|
                                    if i < 5 then
                                        "70px"
                                    else
                                        "370px"
                                , y <|
                                    if i < 5 then
                                        toString ((i * 30) + 100) ++ "px"
                                    else
                                        toString (((i - 5) * 30) + 100) ++ "px"
                                , fill "white"
                                ]
                                [ text <| toString (i + 1) ++ ". " ++ toString num ++ " (" ++ toString count ++ " / " ++ toString all ++ ")"
                                ]
                            )
                        )
                        counts
                   )
            )
