module Status.State exposing (..)

import Status.Types exposing (Model, Msg(..))
import Animation
import Color exposing (black)


init : ( Model, Cmd Msg )
init =
    { isShown = False
    , time = 0
    , message = "Next game starts soon"
    , g = Animation.style []
    , rect =
        Animation.style
            [ Animation.attr "height" 20 "%"
            , Animation.attr "width" 0 "%"
            , Animation.x 0
            , Animation.attr "y" 40 "%"
            , Animation.fill black
            ]
    , text = Animation.style []
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show val ->
            { model | isShown = val } ! []

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
