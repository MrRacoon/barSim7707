module Component.StatusBar exposing (render)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)

render model =
  let attrs =
    [ style [ ("width", "100%")
            ]
    ]
  in div attrs [text (toString model)]
