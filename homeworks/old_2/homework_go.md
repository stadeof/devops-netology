# Домашнее задание к занятию "5. Основы golang"
1. go version: 

```sh
➜  go go version
go version go1.20.1 linux/amd64
```

2. Посмотрел 

3. Перевод метров в футы
```go
package main

import "fmt"

func main() {
	fmt.Print("Введите кол-во метров: ")
	var input float64
	fmt.Scanf("%f", &input)

	output := input / 0.3048

	fmt.Println(output, "футов")
}

```

Наименьший элемент массива

```go
package main

import "fmt"

func main() {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	min := x[0]
	for _, n := range x {
		if n < min {
			min = n
		}
	}
	fmt.Printf("The minimum is %d", min)
}
```

Делится на 3

```go
package main

import "fmt"

func main() {
	for i := 1; i <= 100; i++ {
		if i%3 == 0 {
			fmt.Println(i)
		}
	}
}
```