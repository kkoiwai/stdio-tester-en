#! /bin/sh
## https://github.com/kkoiwai/stdio-tester-en
## Make testing with stdio easier by including test cases in the source code

## Use latest file as source in the current directly if no arg is specified.
src=$1
if [ $# -ne 1 ]; then
  src=`ls -1t | grep -v test.sh | head -n 1` 
fi

## Command to run the source (should be a single line)
runcmd=`cat $src | grep -A1  "^-- COMMAND --" | tail -1`
runcmd="$runcmd $src"
## line no to start input
inputbegin=`cat $src | grep -n  "^-- INPUT --" | sed -e 's/:.*//g' -e '2,$d'`
inputbegin=$[$inputbegin+1]
## line no to end input
inputlineno=`cat $src | tail -n +${inputbegin} | grep -n  "^--" | sed -e 's/:.*//g' -e '2,$d'`
inputlineno=$[$inputlineno-1]
inputend=$[$inputbegin+$inputlineno-1]

## extract input data from source
inputdata=`cat $src | sed -n -e ${inputbegin},${inputend}p`

## line to start expected output
outputbegin=`cat $src | grep -n  "^-- OUTPUT --" | sed -e 's/:.*//g' -e '2,$d'`
outputbegin=$[$outputbegin+1]
## line to end expected output
outputlineno=`cat $src | tail -n +${outputbegin} | grep -n  "^--" | sed -e 's/:.*//g' -e '2,$d'`
outputlineno=$[$outputlineno-1]
outputend=$[$outputbegin+$outputlineno-1]

## extract expected output data from source
outputdata=`cat $src | sed -n -e ${outputbegin},${outputend}p`

## result after running the source
result=`echo "$inputdata" | $runcmd`

## Show the result
echo Command : $runcmd
echo "\nResult :"
echo "$result"
echo "\nExpected :"
echo "$outputdata"
echo "\nDiff :"
echo "$outputdata" | ( echo "$result" | diff /dev/fd/3 -) 3<&0 && echo "OK!"

## diff quits with status 1 if there is a gap
