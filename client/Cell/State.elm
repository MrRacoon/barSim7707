module Cell.State exposing (..)

import Animation
import Cell.Types exposing (Model, Msg(..))
import Utils exposing (location)
import Color exposing (blue)


init : Int -> ( Model, Cmd Msg )
init num =
    { num = num
    , g =
        Animation.style
            [ Animation.translate (Animation.px 0) (Animation.px 0) ]
    , rect =
        Animation.style
            [ Animation.height (Animation.px 10)
            , Animation.width (Animation.px 10)
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
                    location height width model.num
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
                                [ Animation.width (Animation.px loc.width)
                                , Animation.height (Animation.px loc.height)
                                , Animation.fill blue
                                ]
                            ]
                            model.rect
                    , text =
                        Animation.interrupt
                            [ Animation.set
                                [ Animation.x (loc.width / 2)
                                , Animation.y (loc.height / 2)
                                , Animation.custom "font-size" 20 "px"
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
