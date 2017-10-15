module Cell.State exposing (..)

import Animation
import Cell.Types exposing (Model, Msg(..))


init : Int -> Model
init num =
    { num = num
    , g = Animation.style []
    , rect = Animation.style []
    , text = Animation.style []
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateG anim ->
            { model | g = Animation.update anim model.g }

        UpdateRect anim ->
            { model | rect = Animation.update anim model.rect }

        UpdateText anim ->
            { model | text = Animation.update anim model.text }

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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Animation.subscription UpdateG [ model.g ]
        , Animation.subscription UpdateRect [ model.rect ]
        , Animation.subscription UpdateText [ model.text ]
        ]
