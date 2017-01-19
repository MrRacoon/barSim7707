module Component.Number exposing (render)

import Html exposing (li, text)

render num = li [] [ text (toString num) ]
