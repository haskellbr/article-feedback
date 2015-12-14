{-# LANGUAGE OverloadedStrings #-}
module Main
  where

import           Control.Monad.IO.Class        (MonadIO)
import           Data.Aeson                    (object, (.=))
import           Data.Text                     (Text)
import           Network.HTTP.Types
import           Network.Wai.Middleware.Static
import           Web.Spock

jsonInvalid :: MonadIO m => Text -> ActionT m b
jsonInvalid err = do
    setStatus status400
    json $ object [ "ok" .= False
                  , "error" .= (err :: Text)
                  ]

main :: IO ()
main = runSpock 3000 $ spockT id $ do
    post "/ratings" $ do
        setStatus notImplemented501
        text "Not implemented"
        -- case mr :: Maybe Int of
        --     Just r ->
        --         if r < 1 || r > 5
        --         then jsonInvalid "Invalid rating. Provide a number from 1 to 5"
        --         else json $ object ["ok" .= True]
        --     Nothing -> jsonInvalid "Missing or invalid parameter `rating`"

    get "/ratings/jsonp" $ do
        mr <- param "rating"
        case mr :: Maybe Int of
            Just r ->
                if r < 1 || r > 5
                then jsonInvalid "Invalid rating. Provide a number from 1 to 5"
                else json $ object ["ok" .= True]
            Nothing -> jsonInvalid "Missing or invalid parameter `rating`"

    middleware $ staticPolicy (addBase "./client")
