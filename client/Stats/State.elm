module Stats.State exposing (..)

import Stats.Types exposing (Model, Msg(..))
import Animation
import Dict exposing (Dict)


y : Float
y =
    60


init : ( Model, Cmd Msg )
init =
    { isShown = False
    , g =
        Animation.style
            [ Animation.translate (Animation.percent 200) (Animation.percent y)
            ]
    , history = Dict.empty
    , last = []
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show picked ->
            let
                updateHist x =
                    case x of
                        Nothing ->
                            Just 1

                        Just n ->
                            Just <| n + 1
            in
                { model
                    | isShown = True
                    , last = List.take 5 <| picked :: model.last
                    , history =
                        List.foldr
                            (\n -> Dict.update n updateHist)
                            model.history
                            picked
                    , g =
                        Animation.interrupt
                            [ Animation.set
                                [ Animation.translate (Animation.percent 100) (Animation.percent y)
                                ]
                            , Animation.to
                                [ Animation.translate (Animation.percent 40) (Animation.percent y)
                                ]
                            ]
                            model.g
                }
                    ! []

        Hide ->
            { model
                | isShown = False
                , g =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.translate (Animation.percent 100) (Animation.percent y)
                            ]
                        ]
                        model.g
            }
                ! []

        UpdateG amsg ->
            { model | g = Animation.update amsg model.g } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Animation.subscription UpdateG [ model.g ]
        ]
