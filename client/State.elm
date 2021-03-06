module State exposing (..)

import Types exposing (Model, Msg(..), State(..))
import Time exposing (Time, every, second)
import Random exposing (generate, int)
import Constants exposing (pickCount, waitTime, tickTime, rows, cols)
import Window exposing (resizes, size)
import Task exposing (perform)
import Grid.State as Grid
import Grid.Types as GridTypes
import Status.State as Status
import Status.Types as StatusTypes
import Stats.State as Stats
import Stats.Types as StatsTypes


init : ( Model, Cmd Msg )
init =
    let
        ( gridState, gridCmd ) =
            Grid.init

        ( statusState, statusCmd ) =
            Status.init

        ( statsState, statsCmd ) =
            Stats.init
    in
        ({ avail = List.range 1 (cols * rows)
         , picked = []
         , lastDrawn = Nothing
         , startTime = Nothing
         , curTime = 0
         , state = DuringGame
         , screenWidth = 300
         , screenHeight = 300
         , errors = []
         , grid = gridState
         , status = statusState
         , stats = statsState
         }
            ! [ perform ScreenResize size
              , Cmd.map GridMsg gridCmd
              , Cmd.map StatusMsg statusCmd
              , Cmd.map StatsMsg statsCmd
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
                let
                    ( gridState, gridCmd ) =
                        Grid.update (GridTypes.Resize height width) model.grid
                in
                    { model
                        | screenWidth = width
                        , screenHeight = height
                        , grid = gridState
                    }
                        ! [ Cmd.map GridMsg gridCmd ]

            Reset ->
                let
                    ( gridState, gridCmd ) =
                        Grid.update GridTypes.Reset model.grid
                in
                    ({ model
                        | picked = []
                        , lastDrawn = Nothing
                        , state = DuringGame
                        , startTime = Nothing
                        , grid = gridState
                     }
                        ! [ Cmd.map GridMsg gridCmd ]
                    )

            -- For manual intervention
            GetNumber ->
                if List.length model.picked == pickCount then
                    ({ model | picked = [], lastDrawn = Nothing }
                        ! []
                    )
                else
                    ( model, newNumber )

            NewNumber x ->
                if List.length model.picked == pickCount then
                    let
                        ( statusState, statusCmd ) =
                            Status.update (StatusTypes.Show True) model.status

                        ( statsState, statsCmd ) =
                            Stats.update (StatsTypes.Show model.picked) model.stats

                        ( gridState, gridCmd ) =
                            Grid.update (GridTypes.Summary <| List.reverse model.picked) model.grid
                    in
                        ({ model
                            | state = PreGame
                            , lastDrawn = Nothing
                            , startTime = Nothing
                            , status = statusState
                            , stats = statsState
                            , grid = gridState
                         }
                            ! [ Cmd.map StatusMsg statusCmd
                              , Cmd.map GridMsg gridCmd
                              , Cmd.map StatsMsg statsCmd
                              ]
                        )
                else if List.member x model.picked then
                    ( model, newNumber )
                else
                    let
                        ( gridState, gridCmd ) =
                            Grid.update (GridTypes.Pick x) model.grid
                    in
                        ({ model
                            | picked = x :: model.picked
                            , lastDrawn = Just x
                            , grid = gridState
                         }
                            ! [ Cmd.map GridMsg gridCmd ]
                        )

            WaitTick t ->
                case model.startTime of
                    Nothing ->
                        ( { model
                            | curTime = t
                            , startTime = Just t
                          }
                        , Cmd.none
                        )

                    Just s ->
                        if (s + waitTime) < model.curTime then
                            let
                                ( gridState, gridCmd ) =
                                    Grid.update GridTypes.Reset model.grid

                                ( statusState, statusCmd ) =
                                    Status.update (StatusTypes.Show False) model.status

                                ( statsState, statsCmd ) =
                                    Stats.update StatsTypes.Hide model.stats
                            in
                                ({ model
                                    | startTime = Nothing
                                    , state = DuringGame
                                    , picked = []
                                    , lastDrawn = Nothing
                                    , curTime = t
                                    , grid = gridState
                                    , status = statusState
                                    , stats = statsState
                                 }
                                    ! [ Cmd.map GridMsg gridCmd
                                      , Cmd.map StatusMsg statusCmd
                                      , Cmd.map StatsMsg statsCmd
                                      ]
                                )
                        else
                            ( { model | curTime = t }, Cmd.none )

            TimerTick _ ->
                ( model, newNumber )

            GridMsg gmsg ->
                let
                    ( gridState, gridCmd ) =
                        Grid.update gmsg model.grid
                in
                    { model | grid = gridState } ! [ Cmd.map GridMsg gridCmd ]

            StatusMsg smsg ->
                let
                    ( statusState, statusCmd ) =
                        Status.update smsg model.status
                in
                    { model | status = statusState } ! [ Cmd.map StatusMsg statusCmd ]

            StatsMsg smsg ->
                let
                    ( statsState, statsCmd ) =
                        Stats.update smsg model.stats
                in
                    { model | stats = statsState } ! [ Cmd.map StatsMsg statsCmd ]


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
        Sub.batch
            ([ resizes ScreenResize
             , Sub.map GridMsg (Grid.subscriptions model.grid)
             , Sub.map StatusMsg (Status.subscriptions model.status)
             , Sub.map StatsMsg (Stats.subscriptions model.stats)
             ]
                ++ timers
            )
