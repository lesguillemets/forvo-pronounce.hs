{-# LANGUAGE OverloadedStrings #-}
module Interact where

import qualified Network.HTTP.Conduit as HC
import qualified Data.ByteString.Lazy as L

import qualified Response as R
import qualified Query as Q
import Helper
import Const (apiKey)

baseURL = "http://apifree.forvo.com"

askQuery :: (Q.Query q) => q -> IO (Maybe R.WordPronunciations)
askQuery q = HC.withManager $ \m -> do
    let Just poster = HC.parseUrl $ joinPath [ baseURL,
                                             "key/" ++ apiKey,
                                             Q._toURL q ]
    response <- HC.httpLbs (poster { HC.method = "GET",
                                     HC.requestHeaders = [
                                        ("user-agent", "Haskell-HTTP-Conduit")
                                        ]}) m
    decode $ HC.responseBody response

