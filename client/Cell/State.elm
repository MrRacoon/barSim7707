module Cell.State exposing (..)

import Animation
import Cell.Types exposing (Model, Msg(..))
import Utils exposing (location)
import Color exposing (blue)
import Debug exposing (log)


init : Int -> ( Model, Cmd Msg )
init num =
    { num = num
    , g =
        Animation.style
            [ Animation.translate (Animation.px 0) (Animation.px 0) ]
    , rect =
        Animation.style
            [ Animation.attr "height" 10 ""
            , Animation.attr "width" 10 ""
            , Animation.fill blue
            ]
    , text =
        Animation.style
            [ Animation.height (Animation.px 10)
            , Animation.width (Animation.px 10)
            ]
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateG anim ->
            { model | g = Animation.update anim model.g } ! []

        UpdateRect anim ->
            { model | rect = Animation.update anim model.rect } ! []

        UpdateText anim ->
            { model | text = Animation.update anim model.text } ! []

        UpdateScreenSize height width ->
            let
                loc =
                    log "loc"
                        (location height width model.num)
            in
                { model
                    | g =
                        Animation.interrupt
                            [ Animation.to
                                [ Animation.translate
                                    (Animation.px loc.x)
                                    (Animation.px loc.y)
                                ]
                            ]
                            model.g
                    , rect =
                        Animation.interrupt
                            [ Animation.set
                                [ Animation.attr "height" loc.height ""
                                , Animation.attr "width" loc.width ""
                                , Animation.fill blue
                                ]
                            ]
                            model.rect
                    , text =
                        Animation.interrupt
                            [ Animation.set
                                [ Animation.x (loc.width / 4)
                                , Animation.y (loc.height / 1.3)
                                , Animation.custom "font-size" 50 "px"
                                , Animation.exactly "font-family" "Verdana"
                                ]
                            ]
                            model.text
                }
                    ! []

        UpdatePosition x y ->
            { model
                | g =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.x x
                            , Animation.y y
                            ]
                        ]
                        model.g
            }
                ! []

        UpdateColor c ->
            { model
                | rect =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.fill c
                            ]
                        ]
                        model.rect
            }
                ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Animation.subscription UpdateG [ model.g ]
        , Animation.subscription UpdateRect [ model.rect ]
        , Animation.subscription UpdateText [ model.text ]
        ]
