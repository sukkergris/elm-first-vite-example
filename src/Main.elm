module Main exposing (main)

import Browser
import Html exposing (Html, text)


main : Program () () Never
main =
    Browser.sandbox
        { init = ()
        , view = \_ -> text "Using vite server plugin to alter HTML!"
        , update = \_ model -> model
        }