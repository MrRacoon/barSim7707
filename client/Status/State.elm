module Status.State exposing (..)

import Status.Types exposing (Model, Msg(..))
import Animation
import Color exposing (black, white, blue, red)


y : Float
y =
    70


init : ( Model, Cmd Msg )
init =
    { isShown = False
    , message = "Next game in:"
    , g =
        Animation.style
            [ Animation.translate (Animation.percent -100) (Animation.percent y)
            ]
    , rect =
        Animation.style
            [ Animation.attr "height" 20 "%"
            , Animation.attr "width" 30 "%"
            , Animation.fill black
            ]
    , text =
        Animation.style
            [ Animation.y 50
            , Animation.attr "font-size" 50 "px"
            , Animation.exactly "font-family" "Verdana"
            , Animation.fill white
            ]
    , timer =
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
                                [ Animation.translate (Animation.percent -100) (Animation.percent y)
                                ]
                            , Animation.to
                                [ Animation.translate (Animation.percent 0) (Animation.percent y)
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
                                [ Animation.translate (Animation.percent -100) (Animation.percent y)
                                ]
                            ]
                            model.g
                }
                    ! []

        UpdateMessage str ->
            { model | message = str } ! []

        UpdateG amsg ->
            { model | g = Animation.update amsg model.g } ! []

        UpdateRect amsg ->
            { model | rect = Animation.update amsg model.rect } ! []

        UpdateText amsg ->
            { model | text = Animation.update amsg model.text } ! []

        UpdateTimer amsg ->
            { model | timer = Animation.update amsg model.timer } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Animation.subscription UpdateG [ model.g ]
        , Animation.subscription UpdateRect [ model.rect ]
        , Animation.subscription UpdateText [ model.text ]
        , Animation.subscription UpdateTimer [ model.timer ]
        ]
