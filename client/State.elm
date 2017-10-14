module State exposing (..)

import Types exposing (Model, Msg(..), State(..))
import Time exposing (Time, every, second)
import Random exposing (generate, int)
import Constants exposing (pickCount, waitTime, tickTime)
import Window exposing (resizes, size)
import Task exposing (perform)
import Grid.State as Grid


init : ( Model, Cmd Msg )
init =
    let
        ( gridState, gridCmd ) =
            Grid.init
    in
        ({ avail = List.range 1 80
         , picked = []
         , lastDrawn = Nothing
         , startTime = Nothing
         , curTime = 0
         , state = DuringGame
         , screenWidth = 300
         , screenHeight = 300
         , errors = []
         , grid = gridState
         }
            ! [ perform ScreenResize size
              , Cmd.map GridMsg gridCmd
              ]
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
            ScreenResize { width, height } ->
                { model | screenWidth = width, screenHeight = height } ! []

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
                if List.length model.picked == pickCount then
                    ( { model | picked = [], lastDrawn = Nothing }
                    , Cmd.none
                    )
                else
                    ( model, newNumber )

            NewNumber x ->
                if List.length model.picked == pickCount then
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
                        if (s + waitTime) <= model.curTime then
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

            GridMsg gmsg ->
                let
                    ( gridState, gridCmd ) =
                        Grid.update gmsg model.grid
                in
                    { model | grid = gridState } ! [ Cmd.map GridMsg gridCmd ]


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        timers =
            case model.state of
                PreGame ->
                    [ every second WaitTick
                    ]

                DuringGame ->
                    [ every tickTime TimerTick
                    ]
    in
        Sub.batch (timers ++ [ resizes ScreenResize ])
