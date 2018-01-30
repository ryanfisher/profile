```
module Admin exposing (..)

import Phoenix.Socket
import Phoenix.Channel
import Phoenix.Push
import Html exposing (..)
import Time as Time exposing (Time)

type alias AdminModel =
  { phxSocket : Phoenix.Socket.Socket Msg
  }

type Msg =
  Heartbeat Time
  | PhoenixMsg (Phoenix.Socket.Msg Msg)

sendHeartbeatMessage : Phoenix.Socket.Socket Msg -> (Phoenix.Socket.Socket Msg, Cmd (Phoenix.Socket.Msg Msg))
sendHeartbeatMessage socket =
  let
    push = Phoenix.Push.init "heartbeat" "admin:lobby"
  in
    Phoenix.Socket.push push socket

sendGenericMessage : (Phoenix.Socket.Socket Msg -> (Phoenix.Socket.Socket Msg, Cmd (Phoenix.Socket.Msg Msg))) -> AdminModel -> (AdminModel, Cmd Msg)
sendGenericMessage func model =
  let
    (phxSocket, phxCmd) = func model.phxSocket
  in
    ({ model | phxSocket = phxSocket }, Cmd.map PhoenixMsg phxCmd)

update : Msg -> AdminModel -> (AdminModel, Cmd Msg)
update msg model =
  case msg of
    Heartbeat _ ->
      sendGenericMessage sendHeartbeatMessage model
    _ ->
      (model, Cmd.none)

mainView : AdminModel -> Html Msg
mainView model =
  div [] []

subscriptions : AdminModel -> Sub Msg
subscriptions model =
  Sub.batch
    [ Phoenix.Socket.listen model.phxSocket PhoenixMsg
    , Time.every (Time.second * 30) Heartbeat
    ]

phoenixChannel : Phoenix.Channel.Channel msg
phoenixChannel =
  Phoenix.Channel.init "admin:lobby"

phoenixSocket : String -> String -> Phoenix.Socket.Socket Msg
phoenixSocket host token =
  Phoenix.Socket.init ("ws://" ++ host ++ "/socket/websocket?token=" ++ token)

joinSocket : String -> String -> (Phoenix.Socket.Socket Msg, Cmd (Phoenix.Socket.Msg Msg))
joinSocket host token =
  Phoenix.Socket.join phoenixChannel (phoenixSocket host token)

type alias Flags =
  { token : String
  , host : String
  , listId : String
  }

init : Flags -> (AdminModel, Cmd Msg)
init flags =
  let
    ( phxSocket, phxCmd ) = joinSocket flags.host flags.token
  in
    ({ phxSocket = phxSocket }, Cmd.map PhoenixMsg phxCmd)

main =
    Html.programWithFlags
      { init = init
      , view = mainView
      , update = update
      , subscriptions = subscriptions
      }
```
