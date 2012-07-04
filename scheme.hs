module Main where
import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)
import System

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

readExpr :: String -> String
readExpr input = case parse (spaces >> symbol) "lisp" input of
  Left err  -> "No match: " ++ show err
  Right val -> "Found value"

spaces :: Parser ()
spaces = skipMany1 space

data LispVal = Atom String
             | List [LispVal]
             | DottedList [LispVal] LispVal
             | Number Integer
             | String String
             | Bool Bool


main :: IO ()
main = do
  args <- getArgs
  putStrLn (readExpr(args !! 0))


