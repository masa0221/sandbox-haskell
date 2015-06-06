import Data.Char

encode :: Int -> String -> String
-- encode offset msg = map (\c -> chr $ ord c + offset) msg
encode offset msg = map (chr . (+ offset) . ord) msg

decode :: Int -> String -> String
decode shift msg = encode (negate shift) msg
