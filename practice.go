/*
閏年判定問題
http://paiza.jp/challenges/practice

-- TEST SCRIPT at https://github.com/kkoiwai/stdio-tester
-- COMMAND --
go run
-- INPUT --
4
1000
1992
2000
2001
-- OUTPUT --
1000 is not a leap year
1992 is a leap year
2000 is a leap year
2001 is not a leap year

--
*/
package main
import (
    "bufio"
    "fmt"
    "os"
    "strconv"
)
func main(){
    // 自分の得意な言語で
    // Let's チャレンジ！！
    scanner := bufio.NewScanner(os.Stdin)
    scanner.Scan() 
    for scanner.Scan() {
        i, err := strconv.Atoi(scanner.Text())
        if err != nil {
            continue
        }
        if leap(i) {
            fmt.Println(strconv.Itoa(i) + " is a leap year")
        }else{
            fmt.Println(strconv.Itoa(i) + " is not a leap year")
        }
    }
    
}
func leap(n int) bool{
    // 西暦が4で割り切れない年は閏年ではない。
    if n % 4 != 0 {
        return false
    }
    // 100で割り切れ,400で割り切れない年は閏年ではない。
    if n % 100 == 0 && n % 400 !=0 {
        return false
    }
    return true
}