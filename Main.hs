import qualified Interact as I
import qualified Response as R
import qualified Query as Q

main = do
    let query = Q.WordPronQuery {
        _format = Q.Json,
        _word = "forvo",
        _language = Nothing,
        _country = Nothing,
        _username = Nothing,
        _sex = Nothing,
        _rate = Nothing,
        _limit = Nothing,
        _groupInLanguages = Nothing
    }
    n <- I.askQuery query
    case n of
        Nothing -> print "JIJIJI"
        Just r -> print . head . R._items $ r
    print "HOO"
