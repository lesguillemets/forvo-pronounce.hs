module Query where
import Data.Char (toLower)
import Control.Applicative ((<$>))
import Helper
data Format = Json | Xml | JsTag

instance Show Format where
    show Json = "json"
    show Xml = "xml"
    show JsTag = "js-tag"

data Order = Order SQual SOrder
data SQual = SDate | SRate
data SOrder = SAsc | SDesc

instance Show Order where
    show (Order q o) = show q ++ "-" ++ show o

instance Show SQual where
    show SDate = "date"
    show SRate = "rate"

instance Show SOrder where
    show SAsc = "ask"
    show SDesc = "desk"

data WordPronQuery = WordPronQuery {
    _format :: Format,
    _word :: String,
    _language :: Maybe String,
    _country :: Maybe String,
    _username :: Maybe String,
    _sex :: Maybe String,
    _rate :: Maybe Order,
    _limit :: Maybe Int,
    _groupInLanguages :: Maybe Bool
}

instance Query WordPronQuery where
    _action _ = "word-pronunciations"
    _getQueries q = [
            ("format", show $ _format q),
            ("word", _word q)]
            ++ catSndMaybes [
                      ("language", _language q),
                      ("country", _country q),
                      ("username", _username q),
                      ("sex", _sex q),
                      ("rate", show <$> _rate q),
                      ("limit", show <$> _limit q),
                      ("group-in-languages", map toLower . show <$> _groupInLanguages q)
                      ]
    _toURL q = let qs = ("action", _action q): _getQueries q
                   in
                       joinPath . map (\(k,v)->k ++ "/" ++ v) $ qs


catSndMaybes :: [(a, Maybe b)] -> [(a,b)]
catSndMaybes [] = []
catSndMaybes ((a,b'):qs) = case b' of
                Nothing -> catSndMaybes qs
                (Just b) -> (a,b) : catSndMaybes qs

class Query a where
    _action :: a -> String
    _getQueries :: a -> [(String,String)]
    _toURL :: a -> String
