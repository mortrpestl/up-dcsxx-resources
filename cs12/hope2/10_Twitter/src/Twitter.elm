module Twitter exposing (main)

import Browser
import Html exposing (Html, div, p, button, input, text)
import Html.Attributes exposing (value, placeholder, style)
import Html.Events exposing (onClick, onInput)
import Dict exposing (Dict)


type Msg
    = MsgUpdateTempText String
    | MsgUpdateTempAuthor String
    | MsgCreatePost
    | MsgRemovePost Int
    | MsgUpdateCommentInput Int String
    | MsgAddComment Int


type alias Comment =
    { content : String
    }


type alias Post =
    { author : String
    , content : String
    , lastAction : Int  -- tick value when last modified; higher = more recent
    , comments : List Comment
    }


type alias Model =
    { currId : Int
    , tick : Int  -- incremented on every mutating action
    , posts : Dict Int Post
    , tempText : String
    , tempAuthor : String
    , commentInputs : Dict Int String
    }


newPost : String -> String -> Int -> Post
newPost author content tick =
    { author = author
    , content = content
    , lastAction = tick
    , comments = []
    }


init : Model
init =
    { currId = 0
    , tick = 0
    , posts = Dict.empty
    , tempText = ""
    , tempAuthor = ""
    , commentInputs = Dict.empty
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgUpdateTempText str ->
            { model | tempText = str }

        MsgUpdateTempAuthor str ->
            { model | tempAuthor = str }

        MsgCreatePost ->
            let
                nextId   = model.currId + 1
                nextTick = model.tick + 1
                post     = newPost model.tempAuthor model.tempText nextTick
            in
            { model
            | posts      = Dict.insert nextId post model.posts
            , currId     = nextId
            , tick       = nextTick
            , tempText   = ""
            , tempAuthor = ""
            }

        MsgRemovePost postId ->
            { model | posts = Dict.remove postId model.posts }

        MsgUpdateCommentInput postId str ->
            { model | commentInputs = Dict.insert postId str model.commentInputs }

        MsgAddComment postId ->
            let
                commentText =
                    Dict.get postId model.commentInputs |> Maybe.withDefault ""

                nextTick = model.tick + 1

                addComment post =
                    { post
                    | comments   = post.comments ++ [ { content = commentText } ]
                    , lastAction = nextTick
                    }
            in
            { model
            | posts         = Dict.update postId (Maybe.map addComment) model.posts
            , commentInputs = Dict.insert postId "" model.commentInputs
            , tick          = nextTick
            }


view : Model -> Html Msg
view model =
    let
        sorted =
            model.posts
                |> Dict.toList
                |> List.sortBy (\( _, post ) -> -post.lastAction)
    in
    div [ style "max-width" "600px", style "margin" "0 auto", style "padding" "16px", style "font-family" "sans-serif" ]
        [ input
            [ placeholder "Author"
            , value model.tempAuthor
            , onInput MsgUpdateTempAuthor
            , style "display" "block", style "margin-bottom" "8px"
            ]
            []
        , input
            [ placeholder "Write something..."
            , value model.tempText
            , onInput MsgUpdateTempText
            , style "display" "block", style "margin-bottom" "8px"
            ]
            []
        , button [ onClick MsgCreatePost ] [ text "Post" ]
        , div [] (List.map (viewPost model) sorted)
        ]


viewPost : Model -> ( Int, Post ) -> Html Msg
viewPost model ( id, post ) =
    let
        commentDraft =
            Dict.get id model.commentInputs |> Maybe.withDefault ""
    in
    div [ style "border" "1px solid #ccc", style "margin" "8px", style "padding" "8px" ]
        [ p [ style "font-weight" "bold" ] [ text post.author ]
        , p [] [ text post.content ]
        , p [ style "font-size" "12px", style "color" "#888" ]
            [ text ("Comments: " ++ String.fromInt (List.length post.comments)) ]
        , div [] (List.map viewComment post.comments)
        , input
            [ placeholder "Add a comment..."
            , value commentDraft
            , onInput (MsgUpdateCommentInput id)
            , style "margin-right" "8px"
            ]
            []
        , button [ onClick (MsgAddComment id) ] [ text "Comment" ]
        , button [ onClick (MsgRemovePost id), style "margin-left" "8px" ] [ text "Remove" ]
        ]


viewComment : Comment -> Html Msg
viewComment comment =
    div [ style "border-left" "2px solid #ccc", style "padding-left" "8px", style "margin" "4px 0" ]
        [ text comment.content ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }