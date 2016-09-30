#! /bin/sh
## https://github.com/kkoiwai/stdio-tester
## 標準入出力のテストケースをソースに埋め込んで１ファイルでテストまで行う便利なシェルスクリプト
## 使い方は http://qiita.com/kkoiwai/items/d70c21f92eaca6bf9939

## 引数が1つ以外の場合はカレントディレクトリの最新ファイルを参照する
src=$1
if [ $# -ne 1 ]; then
  src=`ls -1t | grep -v test.sh | head -n 1` 
fi

## 実行コマンド(１行の前提)
runcmd=`cat $src | grep -A1  "^-- COMMAND --" | tail -1`
runcmd="$runcmd $src"
## 入力データ開始位置
inputbegin=`cat $src | grep -n  "^-- INPUT --" | sed -e 's/:.*//g' -e '2,$d'`
inputbegin=$[$inputbegin+1]
## 入力データ終了位置(開始からの行数)
inputlineno=`cat $src | tail -n +${inputbegin} | grep -n  "^--" | sed -e 's/:.*//g' -e '2,$d'`
inputlineno=$[$inputlineno-1]
inputend=$[$inputbegin+$inputlineno-1]

## 入力データ
inputdata=`cat $src | sed -n -e ${inputbegin},${inputend}p`

## 想定出力データ開始位置
outputbegin=`cat $src | grep -n  "^-- OUTPUT --" | sed -e 's/:.*//g' -e '2,$d'`
outputbegin=$[$outputbegin+1]
## 想定出力データ終了位置(開始からの行数)
outputlineno=`cat $src | tail -n +${outputbegin} | grep -n  "^--" | sed -e 's/:.*//g' -e '2,$d'`
outputlineno=$[$outputlineno-1]
outputend=$[$outputbegin+$outputlineno-1]

## 想定出力データ
outputdata=`cat $src | sed -n -e ${outputbegin},${outputend}p`

## 実行結果
result=`echo "$inputdata" | $runcmd`

## 結果表示
echo 実行コマンド : $runcmd
echo "\n実行結果"
echo "$result"
echo "\n想定実行結果"
echo "$outputdata"
echo "\n比較結果"
echo "$outputdata" | ( echo "$result" | diff /dev/fd/3 -) 3<&0 && echo "OK!"

## 一致しなければ diff がステータス1で終了。