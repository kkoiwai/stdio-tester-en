/*
Leap year checking practice
http://paiza.jp/challenges/practice

-- TEST SCRIPT at https://github.com/kkoiwai/stdio-tester-en
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

    scanner := bufio.NewScanner(os.Stdin)
    // first line represents number of input lines, so just skip
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
    // n is not a leap year if not a multiple of 4
    if n % 4 != 0 {
        return false
    }
    // n is not a leap year if a multiple of 100 but not a multiple of 400
    if n % 100 == 0 && n % 400 !=0 {
        return false
    }
    return true
}
