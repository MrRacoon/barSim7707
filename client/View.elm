module View exposing (..)

import Types exposing (Model, Msg(..))
import Html exposing (Html, div)
import Svg.Lazy exposing (lazy, lazy3)
import Constants exposing (waitTime)
import Grid.View as Grid
import Status.View as Status
import Stats.View as Stats
import Svg exposing (Svg, svg, rect)
import Svg.Attributes exposing (height, width, fill)
import Date exposing (fromTime, minute, second)


view : Model -> Html Msg
view model =
    let
        ( mins, secs ) =
            case model.startTime of
                Nothing ->
                    ( 0, 0 )

                Just s ->
                    let
                        till =
                            (s + waitTime) - model.curTime
                    in
                        if till > 0 then
                            ( till |> fromTime |> minute
                            , till |> fromTime |> second
                            )
                        else
                            ( 0, 0 )
    in
        svg
            [ height <| toString model.screenHeight, width <| toString model.screenWidth ]
            [ rect
                [ height <| toString model.screenHeight
                , width <| toString model.screenWidth
                , fill "grey"
                ]
                []
            , Svg.map GridMsg (lazy Grid.view model.grid)
            , Svg.map StatusMsg <| lazy3 Status.view model.status mins secs
            , Svg.map StatsMsg <| lazy Stats.view model.stats
            ]
