module State exposing (..)

import Types exposing (Model, Msg(..), State(..))
import Time exposing (Time, every, second)
import Random exposing (generate, int)


init : ( Model, Cmd msg )
init =
    ( { avail = List.range 1 80
      , picked = []
      , pickCount = 10
      , lastDrawn = Nothing
      , startTime = Nothing
      , waitTime = 10 * second
      , tickTime = 3 * second
      , curTime = 0
      , state = DuringGame
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        lenAvail =
            List.length model.avail

        newNumber =
            generate NewNumber (int 1 lenAvail)
    in
        case msg of
            Reset ->
                ( { model
                    | picked = []
                    , lastDrawn = Nothing
                    , state = DuringGame
                    , startTime = Nothing
                  }
                , Cmd.none
                )

            -- For manual intervention
            GetNumber ->
                if List.length model.picked == model.pickCount then
                    ( { model | picked = [], lastDrawn = Nothing }
                    , Cmd.none
                    )
                else
                    ( model, newNumber )

            NewNumber x ->
                if List.length model.picked == model.pickCount then
                    ( { model
                        | state = PreGame
                        , lastDrawn = Nothing
                        , startTime = Nothing
                      }
                    , Cmd.none
                    )
                else if List.member x model.picked then
                    ( model, newNumber )
                else
                    ( { model
                        | picked = x :: model.picked
                        , lastDrawn = Just x
                      }
                    , Cmd.none
                    )

            WaitTick t ->
                case model.startTime of
                    Nothing ->
                        ( { model | curTime = t, startTime = Just t }, Cmd.none )

                    Just s ->
                        if (s + model.waitTime) <= model.curTime then
                            ( { model
                                | startTime = Nothing
                                , state = DuringGame
                                , picked = []
                                , lastDrawn = Nothing
                                , curTime = t
                              }
                            , Cmd.none
                            )
                        else
                            ( { model | curTime = t }, Cmd.none )

            TimerTick t ->
                ( model, newNumber )


subscriptions : { a | state : State, tickTime : Time } -> Sub Msg
subscriptions model =
    case model.state of
        PreGame ->
            Sub.batch
                [ every second WaitTick
                ]

        DuringGame ->
            Sub.batch
                [ every model.tickTime TimerTick
                ]
