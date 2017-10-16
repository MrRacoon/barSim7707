module Status.State exposing (..)

import Status.Types exposing (Model, Msg(..))
import Animation
import Color exposing (black, white, blue, red)


init : ( Model, Cmd Msg )
init =
    { isShown = False
    , time = 0
    , message = "Next game starts soon"
    , g =
        Animation.style
            [ Animation.translate (Animation.percent -100) (Animation.percent 40)
            ]
    , rect =
        Animation.style
            [ Animation.attr "height" 20 "%"
            , Animation.attr "width" 100 "%"
            , Animation.fill black
            ]
    , text =
        Animation.style
            [ Animation.y 100
            , Animation.attr "font-size" 50 "px"
            , Animation.exactly "font-family" "Verdana"
            , Animation.fill white
            ]
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show val ->
            if val then
                { model
                    | g =
                        Animation.interrupt
                            [ Animation.set
                                [ Animation.translate (Animation.percent -100) (Animation.percent 40)
                                ]
                            , Animation.to
                                [ Animation.translate (Animation.percent 0) (Animation.percent 40)
                                ]
                            ]
                            model.g
                }
                    ! []
            else
                { model
                    | g =
                        Animation.interrupt
                            [ Animation.to
                                [ Animation.translate (Animation.percent 200) (Animation.percent 40)
                                ]
                            ]
                            model.g
                }
                    ! []

        UpdateTimer val ->
            { model | time = val } ! []

        UpdateMessage str ->
            { model | message = str } ! []

        UpdateG amsg ->
            { model | g = Animation.update amsg model.g } ! []

        UpdateRect amsg ->
            { model | rect = Animation.update amsg model.rect } ! []

        UpdateText amsg ->
            { model | text = Animation.update amsg model.text } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Animation.subscription UpdateG [ model.g ]
        , Animation.subscription UpdateRect [ model.rect ]
        , Animation.subscription UpdateText [ model.text ]
        ]
