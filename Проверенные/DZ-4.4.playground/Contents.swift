import UIKit

//https://github.com/netology-code/bios-homeworks/tree/master/4.4

/*
 Задание №1
 История:
 Вы разрабатываете спутник для полета на Европу (спутник Юпитера). В вашей команде два ученых по космодинамике. Вы даете каждому из них задачу расчитать количество топлива для достижения спутником цели.
 Данные, которые они получают — это вес спутника и длина полета. Они должны вам предоставить свои алгоритмы расчетов топлива (это ваши амыкания). А вы по готовности алгоритмов делаете обработку данных и сравниваете результат (это ваша функция).

 Алгоритм выполнения
 1. Написать функцию с входящим параметром — замыкание (тип указан выше). Функция должна выводить в консоль результат выполнения Замыкания.
 2. Написать два замыкания (тип указан выше). Внутри должна быть математическая операция (на ваш выбор) над входящими значениями.
 3. Вызвать функцию для первого замыкания и потом для второго замыкания.
 4. Выполнить задание, не сокращая синтаксис языка
 
 Тип для Замыкания: на входе два параметра Double, На Выходе Double.
 */

let algo1 = { (weight: Double, distance: Double) -> Double in return weight * distance * 0.5 } // Перед типом пробел, напр: weight: Double !FIXED!
let algo2 = { (weight, distance) -> Double in distance / weight * 0.5 }

func closureFunc(op1: Double, op2: Double,operation: (Double, Double) -> Double) { // Та же ситуация. пробелы перед типами у параметров + между параметрами и в замыкании между типами пробелы operation: (Double, Double) -> Double Вот так !FIXED!
    // Я подумал еще по поводу этого задания. Там же написано, что данные они получают, поэтому можно и в методе прям эти данные сделать. Но это не критично, просто размышления
    print(operation(op1,op2))
}
closureFunc(op1: 1, op2: 2, operation: algo1) // можно не ставить .0, если число ровное !FIXED!


//  Задание №2: Представить задание 1 в сокращенном виде
closureFunc(op1: 1.0, op2: 2.0) { (op1, op2) -> Double in op2 / op1 * 0.5 } // Не совсем сокращенный вид))

/*
 Скорее вот так, но это не точно)) Твой вариант тоже хороший))
let algo3: (Double, Double) -> Double = { return $0 * $1 * 0.5 }
closureFunc(op1: 1, op2: 2, operation: algo3)
*/

// Задание №3: Вызвать функцию из задания 1, определив ей замыкание самостоятельно (не передавая).
/*
 Пример:
 func example(param: () -> Void) {
     // ...
 }
     
 example {
     // ...
 }
 */

func closureFuncShort(op1:Double, op2:Double,operation:(Double,Double)->Double) {
    print(operation(op1,op2))
}

// ВОт так мб...то есть то, что ты делал в прошлом задании. Видимо, там по-другому решается вторая задачка. Скорее всего, как я показал
closureFunc(op1: 1, op2: 2) { (first, second) -> Double in
    first * second * 0.5
}
// Я хз нужно ли менять функцию чтобы она была как в примере, т.е. closureFuncShort(param: () -> Void), и не знаю, как это сделать, если нужно


