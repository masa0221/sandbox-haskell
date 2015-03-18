3.1 パターンマッチ
========================
『すごいHaskell 楽しく学ぼう!』
3章 関数の構文について のまとめ

## パターンマッチ
### 渡された数が7かどうか調べる関数

```haskell
lucky :: Int -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"
```
任意の値は小文字から始まる名前を書く(この場合x)

```
*Main> lucky 7
"LUCKY NUMBER SEVEN!"
*Main> lucky 3
"Sorry, you're out of luck, pal!"
```

### 1〜5を渡すと単語で返す関数

```haskell
sayMe :: Int -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"
```

```
*Main> sayMe 3
"Three!"
*Main> sayMe 5
"Five!"
*Main> sayMe 10
"Not between 1 and 5"
```


```haskell
sayMe :: Int -> String
sayMe x = "Not between 1 and 5"
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
```
最初にどんな数でもマッチするものを持ってくると下のパターンにマッチしない

```
*Main> sayMe 5
"Not between 1 and 5"
*Main> sayMe 10
"Not between 1 and 5"
```

上記のような関数を定義したファイルを読み込むと以下のWarningが出力される
```
*Main> :l 3-function.hs
[1 of 1] Compiling Main             ( 3-function.hs, interpreted )

3-function.hs:6:1: Warning:
    Pattern match(es) are overlapped
    In an equation for ‘sayMe’:
        sayMe 1 = ...
        sayMe 2 = ...
        sayMe 3 = ...
        sayMe 4 = ...
        ...
Ok, modules loaded: Main.
```

### 関数を再帰的に定義

```haskell
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

### パターンマッチの失敗

予期しない値が来るとエラーになる
```haskell
charName :: Char -> String 
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"
```
'a' 'b' 'c' 以外はエラーになる。

```
*Main> charName 'a'
"Albert"
*Main> charName 'd'
"*** Exception: 3-function.hs:(18,1)-(20,22): Non-exhaustive patterns in function charName
```

上記のエラーを避けるため、
すべての値に合致するパターンを入れておくべき。
```
charName :: Char -> String 
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"
charName x   = "Not defined."
```
'a' 'b' 'c' 以外は"Not defined."になる。


```
*Main> charName 'd'
"Not defined."
```

## タプルのパターンマッチ
### 2つの2次元空間のベクトルを受け取り、それらを足し合わせる関数

```haskell
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors a b = (fst a + fst b, snd a + snd b)
```

```
*Main> addVectors (1, 3) (2, 4)
(3.0,7.0)
```

パターンマッチを使うと以下の書き方になる。
```haskell
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
```

### first, second, third
トリプルを渡すと、1番目を返す、2番目を返す、3番目を返す関数

```haskell
-- 1番目を返す
first :: (a, b, c) -> a
first (x, _, _) = x

-- 2番目を返す
second :: (a, b, c) -> b
second (_, y, _) = y

-- 3番目を返す
third :: (a, b, c) -> c
third (_, _, z) = z
```
`_`は使い捨ての変数。

```
*Main> first (10, 20, 30)
10
*Main> second (10, 20, 30)
20
*Main> third (10, 20, 30)
30
```

## リストのパターンマッチとリスト内包表記

### 2番目の値が3になっているタブルの1番目を返す
```
*Main> let xs = [(1, 3), (4, 3), (2, 4), (5, 3), (5, 6), (3, 1)]
*Main> [x | (x, 3) <- xs]
[1,4,5]
```
(x, 3) には、
(1, 3), (4, 3), (5, 3) の3つがヒットするのでタプル1番目の1,4,5のリストになる


### headをリストのパターンマッチを使って実装
リストの先頭が取得出来る関数を実装する。

```
*Main> 1:2:3:[]
[1,2,3]
```
`[1,2,3]`は`1:2:3:[]`の糖衣構文(syntax sugar)なので
`x:xs`というパターンは`x`にリストの先頭の要素、`xs`に先頭以外の残りの要素を束縛される。


```haskell
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x
```
xに先頭の要素を束縛させる(`_`は残りの要素だが利用しないので使い捨ての変数)

```
*Main> head' [4, 5, 6]
4
*Main> head' "Hello"
'H'
```


### 漏れの無いパターンマッチ
リストの要素を回りくどくて不便な書式で出力する関数を作成する。

```haskell
tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "The list is long. The first two elements are: " ++ show x ++ " and " ++ show y
```

```
*Main> tell [1]
"The list has one element: 1"
```
`(x:[])` に合致


```
*Main> tell [True, False]
"The list has two elements: True and False"
```
`(x:y:[])` に合致

```
*Main> tell [1, 2, 3, 4]
"The list is long. The first two elements are: 1 and 2"

*Main> tell [1, 2, 3, 4, 5, 6, 7, 8, 9]
"The list is long. The first two elements are: 1 and 2"
```
`(x:y:_)` に合致(任意の長さのリストに合致)
※これがあるので常に値を返すことが出来る。

```
*Main> tell []
"The list is empty"
```
`[]` に合致

### 漏れがあるパターンマッチ

```haskell
badAdd :: (Num a) => [a] -> a
badAdd (x:y:z:[]) = x + y + z
```

```
*Main> badAdd [100, 200, 300]
600
```
パターンに合致する場合

```
*Main> badAdd [100, 200]
*** Exception: 3-function.hs:44:1-29: Non-exhaustive patterns in function badAdd

*Main> badAdd [100, 200, 300, 400]
*** Exception: 3-function.hs:44:1-29: Non-exhaustive patterns in function badAdd
```
予期しないリストが与えられた場合、エラーになる。

### パターンマッチの注意点
演算子は利用できない。

```haskell
badPattern :: [a] -> a
badPattern (xs ++ xy) = xy
```

```
Prelude> :l 3-function.hs
[1 of 1] Compiling Main             ( 3-function.hs, interpreted )

3-function.hs:47:13: Parse error in pattern: xs ++ xy
Failed, modules loaded: none.
```
エラーになる。

```haskell
badPattern :: [a] -> a
badPattern (xs ++ [x, y, z]) = x + y + z
```

```
Prelude> :l 3-function.hs
[1 of 1] Compiling Main             ( 3-function.hs, interpreted )

3-function.hs:47:13: Parse error in pattern: xs ++ [x, y, z]
Failed, modules loaded: none.
```
これもエラーになる。

## asパターン

```haskell
firstLetter :: String -> String
firstLetter "" = "Empty string, whoops!"
firstLetter all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
```
`all`は元の値全体になる。

```
*Main> firstLetter "Dracura"
"The first letter of Dracura is D"
```
