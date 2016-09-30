# stdio-tester-en
Make testing with stdio easier by including test cases in the source code

## How to use
 - ```chmod u+x test.sh```
 - save the source code to test in the same direcory, and
    - create multiple-line comment section, add a line starting ```-- COMMAND --``` and type commants to run the source (e.g. ```go run```）
    - add a line startng ```-- INPUT --``` and paste input to feed stdin. The section ends with a line starting ```--``` (e.g. ```-- OUTPUT --```）
    - add a line starting ```-- OUTPUT --```and paste expected output to stdout. The section ends with a line starting ```--``` 
 - run ```./test.sh``` and it executes the latest file in the current directory. The output looks like
 
 
```
$ ./test-en.sh
Command : go run practice.go

Result :
1000 is not a leap year
1992 is a leap year
2000 is a leap year
2001 is not a leap year

Expected :
1000 is not a leap year
1992 is a leap year
2000 is a leap year
2001 is not a leap year

Diff :
OK!

```
