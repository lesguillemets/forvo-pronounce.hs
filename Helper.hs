module Helper where

import Data.Char
import Data.List (intercalate)

snakise :: String -> String
snakise [] = []
snakise (c:cs) = if isUpper c
                    then '_' : toLower c : snakise cs
                    else c:snakise cs

joinPath :: [String] -> String
joinPath = intercalate "/"
