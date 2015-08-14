{-# LANGUAGE MonadComprehensions #-}
import Prelude hiding (maybe)
import Control.Applicative

data MyMaybe a = MyJust a | MyNothing deriving (Show)

-- 夏休みの宿題 MyMaybeの作成。Maybeを自分で実装しよう (モナドは関係ない)

-- このファイルに書かれたテストを実行するにはdoctestを利用します。
-- * stackをつかっている場合は stack install doctest
-- * つかっていない場合は cabal install doctest
-- でインストールできます。
-- 実行するには
-- $ stack exec doctest maybe.hs
-- $ doctest maybe.hs
-- のようになります。

-- 初級
-- 各関数を実装してください
--
-- 中級
-- それぞれScalaではどのような名前のメソッドでしょうか
-- 参考: http://www.scala-lang.org/api/current/index.html#scala.Option
--
-- 上級
-- MyMaybeを内包表記でつかえるようにしてください
-- GHC拡張の設定が必要です。GHCiで使用する場合は
-- > :set -XMonadComprehensions
-- とすればMaybeを内包表記で利用できます。同じようにMyMaybeも対応させてみましょう。
-- 例
-- >>> [x*y| x <- Just 5, y <- Just 3]
-- Just 15
-- >>> [x*y| x <- Just 5, y <- Nothing]
-- Nothing
--
-- ヒント: 型クラスMonadのインスタンスにします。

main = undefined -- doctestの実行に必要なだけなので気にしないでください。

-- MyMaybeをつくってみましょう。

-- | maybe
-- maybeは
-- * 3番目の引数が MyNothingであれば第1引数の値を返します
-- * 3番目の引数が MyJustであれば2番目の引数の関数を適用します。
-- >>> maybe "hoge" show (MyJust 3)
-- "3"
--
-- >>> maybe "hoge" show MyNothing
-- "hoge"
--
maybe :: b -> (a -> b) -> MyMaybe a -> b
maybe = undefined

-- | isJust
-- isJustは値がMyJustかどうか確認する関数です。
--
-- >>> isJust (MyJust 3)
-- True
--
-- >>> isJust MyNothing
-- False
--
-- >>> isJust (MyJust ())
-- True
isJust :: MyMaybe a -> Bool
isJust = undefined

-- | isNothing
-- isNothingtは値がMyNothingかどうか確認する関数です。
--
-- >>> isNothing (MyJust 3)
-- False
--
-- >>> isNothing MyNothing
-- True
--
-- >>> isNothing (MyJust ())
-- False
isNothing :: MyMaybe a -> Bool
isNothing = undefined

-- | fromMaybe
-- fromMaybeはMaybeをはずすための関数で、MyJustの時はMyJustを外した値を返し、
-- MyNothingは第1引数に指定した値を返します。
--
-- >>> fromMaybe "" (MyJust "Hello, World!")
-- "Hello, World!"
--
-- >>> fromMaybe "" MyNothing
-- ""
--
-- >>> fromMaybe 1 (MyJust 5)
-- 5
--
-- >>> fromMaybe 1 MyNothing
-- 1
fromMaybe :: a -> MyMaybe a -> a
fromMaybe = undefined

-- | maybeToList
-- maybeToListはMyMaybeをListに変換する関数です。
--
-- >>> maybeToList (MyJust 1)
-- [1]
--
-- >>> maybeToList MyNothing
-- []
--
-- >>> maybeToList (MyJust "hello")
-- ["hello"]
maybeToList :: MyMaybe a -> [a]
maybeToList = undefined

-- | listToMaybe
-- listToMaybeはListをMyMaybeをListに変換する関数です。
-- Listから変換しようとすると先頭の要素以外の要素を欠落してします。
--
-- >>> listToMaybe [1]
-- MyJust 1
--
-- >>> listToMaybe [1,2,3]
-- MyJust 1
--
-- >>> listToMaybe []
-- MyNothing
listToMaybe :: [a] -> MyMaybe a
listToMaybe = undefined

-- | catMaybes
-- catMaybesはMyMaybeのリストを普通のリストに変換する関数です。
--
-- >>> catMaybes [MyJust 3]
-- [3]
--
-- >>> catMaybes [MyNothing]
-- []
--
-- >>> catMaybes [MyJust 3, MyNothing, MyJust 1, MyNothing]
-- [3,1]
catMaybes :: [MyMaybe a] -> [a]
catMaybes = undefined

-- 上級問題用
instance Functor MyMaybe where
  fmap = undefined

instance Applicative MyMaybe where
  pure = undefined
  (<*>) = undefined

instance Monad MyMaybe where
  (>>=) = undefined
  return = pure

-- |
--
-- >>> :set -XMonadComprehensions
-- >>> [(x*y) | x <- MyJust 2, y <- MyJust 3]
-- MyJust 6
--
-- >>> [(x*y) | x <- MyJust 2, y <- MyNothing]
-- MyNothing
