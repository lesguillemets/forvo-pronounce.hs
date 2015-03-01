{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Response where

import Data.Aeson.TH
import Basal (Url, DateTime)

import Helper (snakise)

data Pronunciation = Pron {
    _id :: Int,
    _word :: String,
    _pathogg :: Url,
    _pathmp3 :: Url,
    _country :: String,
    _langname :: String,
    _code :: String,
    _username :: String,
    _sex :: String,
    _rate :: Int,
    _numPositiveVotes :: Int,
    _numVotes :: Int,
    _hits :: Int,
    _addtime :: DateTime
} deriving (Show)

$(deriveJSON defaultOptions {fieldLabelModifier = snakise . drop 1} ''Pronunciation)

data Attributes = Attributes { _total :: Int } deriving (Show)
$(deriveJSON defaultOptions {fieldLabelModifier = snakise . drop 1} ''Attributes)

data WordPronunciations = WordPronunciations {
    _attributes :: Attributes,
    _items :: [Pronunciation]
} deriving (Show)
$(deriveJSON defaultOptions {fieldLabelModifier = snakise . drop 1} ''WordPronunciations)
