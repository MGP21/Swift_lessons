import UIKit
//: Домашнее задание необходимо выполнить в данном файле, перед отправкой переименуйте название файла (латиницей) в формате ФамилияГруппаDZ4_3, например, *IvanovIOS4_DZ4_3*, заархивировать и приложить в личном кабинете для проверки.
/*:
 Чтобы успешно выполнить это домашнее задание, необходимо усвоить следующие темы:
 * [Коллекции eng.](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html)
 * [Коллекции  рус.](https://swiftbook.ru/content/languageguide/collection-types/)
 * [Управление потоком eng.](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html)
 * [Управление потоком рус.](https://swiftbook.ru/content/languageguide/control-flow/)
 * [Функции eng.](https://docs.swift.org/swift-book/LanguageGuide/Functions.html)
 * [Функции рус.](https://swiftbook.ru/content/languageguide/functions/)
*/
//: ## Задача №1
//: В данной задаче Вы тренируетесь Добавлять и Удалять значения в **`Хранилище (массив)`** при помощи двух функций, которые Вам и нужно реализовать. Функции принимают значение, но ничего не возвращают.
//: Первая функция добавляет элемент в массив, вторая функция удаляет элемент из массива, вы сами можете выбрать любой удобный для вас вариант добавления и удаления элементов из массива.
//: ### Алгоритм решения:
//:  * Создайте пустой массив строк типа String на любимую тематику, например, это будет Хранилище столовых приборов (этот пример не использовать), в который вы будете поочередно добавлять или удалять ложки, вилки и т.п. приборы.
//: * Создайте 2 функции в соответствии с условием.
//: * Попробуйте добавлять и удалять значения в массиве при помощи созданных функций.
//: * Что произойдет, если попытаетесь удалить значение, которого нет в Хранилище? Напишите, что в этом случае вы можете изменить в своей функции и внесите в нее изменения.
//: * *(условие со звездочкой - не обязательное) обе функции должны принимать массив и значение. Они должны добавлять или удалять значения в массиве. Функция удаления должна быть безопасной, т.е. если Хранилище пустое, мы должны сообщить об этом пользователю, если запрашиваемое на удаление значение отсутствует, необходимо также сообщить, что такого элемента нет. Запрещается использование forced unwrapping, если в вашем варианте будет необходимость работать с опционалами.*
// Решение задачи №1:
print("hello")
var fridge = [String] () // перед () пробел не нужен
func addProducts (_ products: String...) { // Там где-то в первых лекциях было про camelCase. Это стиль именования, когда каждое следующее слово начинается с большой буквы, напр: addProducts !FIXED!
    // По условию нужно добавлять один продукт, но так тоже сойдет))
    fridge.append(contentsOf: products)
    print("\(products) was added to the fridge")
}

func delproducts (_ products: String...) {
    print(fridge)
    if fridge.count != 0 { // У массива есть свойство isEmpty + я думаю, что это лишнее условие
        for product in products { // у массива есть метод под капотом enumerated(). Он преобразует массив в кортеж вида (index, element)..
            // for (index, product) in products.enumerated() {}
            if fridge.contains(product) { // тут перед точкой не нужен пробел !FIXED!
                if let productIndex = fridge.firstIndex(of: product) { // firstIndex возвращает optional, раскрываем так, потому что force unwrap(!) нельзя использовать
                    fridge.remove(at: productIndex) // product_index - так нельзя писать имена. productIndex !FIXED!
                    print("\(product) was deleted")
                    print("Fridge: \(fridge)")
                }
            }
            else { print("No \(product) in the fridge") } // Так нельзя делать. Считается плохим тоном писать в циклах вот так. Есть исключения, но в большинстве случаев так не делается
        }
    }
    else {print("Fridge is empty")}
}

/*
 можно было вот так переписать метод
 for (index, product) in products.enumerated() {
     guard fridge.contains(product) else { return }
     fridge.remove(at: index)
 }
 Попробовал - получается что-то не то.
 */


// Демонстрация
delproducts("banana")
print("------")
addProducts("ham", "eggs")
addProducts("cheese", "eggs")
addProducts("bread")
delproducts("bread", "mayo", "eggs")
print("--------")
delproducts("cheese", "eggs")

//: ## Задача №2
//: Вы получили тестовое задание от службы доставки еды: преобразовать бонусные баллы клиентов, которые хранятся на сайте, в денежные единицы. Со стороны сайта приходит словарь, содержащий ID клиента **(Int)** и накопленную сумму Бонусов **(Double)**. Ваша задача вернуть на сайт словарь, содержащий ID клиента **(Int)** и конвертированные денежные единицы **(Int)**, каждые 100 бонусов равны 10 денежным единицам.
//: ### Алгоритм решения:
//: * Словарь со своими значениями создавать не нужно. Значения, с которыми вы будете работать, инкапсулированы и переданы в `userPoints`.
//: * Распечатайте словарь и посмотрите, с какими значениями вы будете работать.
//: * Создайте функцию, которая принимаем словарь, ключом которого будет тип Integer, значением число с плавающей точкой Double, вернуть необходимо словарь ключом и значением, которого будет Integer.
//: * Вызовите функцию и распечатайте полученный результат.
//: * Дополнительно(не обязательно) входящих параметров может быть больше, например, для коэффициента пересчета баллов в денежные единицы.
// Решение задачи №2:
// подготовленный словарь
userPoints
//print(userPoints)
//print("---------")
func bonus (params: [Int: Double], coef: Double = 1.0) -> [Int: Int] { // словарь в короткой форме можно задавать вот так: [Int: Double]. Кородкая форма предпочтительнее !FIXED!
    let newDict = params.mapValues { Int($0 * coef) } // Тут прям молодец. Доебаться кроме нэйминга не к чему, но к нэймингу я уже доебывался
    return newDict
}
//print(bonus(params: userPoints, coef: 0.5))
//: ## Задача №3 (*)
//:  Вам необходимо реализовать функцию, которая принимаем массив опциональных значений типа Integer и возвращает кортеж, в который необходимо передать сумму четных и нечетных значений.
//: - Массив может содержать повторяющиеся и nil значения, например: `[1, 2, nil, 12, 1, nil, 3, 2]`.
//: - В вычислении должны быть использованы только уникальные значения, а повторяющиеся учитываться не должны. Например, у нас повторяются числа 1 и 2, но попадать в результат они должны один раз; сумма нечетных будет `(1 + 3 = 4)`, четных `(2 + 12 = 14)`.
//:  - Так как в массиве могут быть nil, а вернуть необходимо неопциональное значение, необходимо использовать безопасное развертывание опционала (optional binding).
//:  - Для проверки вашего решения передайте в функцию подготовленный массив `arrayOfNumbers`.
//:  - Массив со своими значениями создавать не нужно. Значения, с которыми вы будете работать, инкапсулированы и переданы в `arrayOfNumbers`.
//:  - Распечатайте массив и посмотрите, с какими значениями вы будете работать.
//:  - Если вы все правильно сделаете, то получите ответ: `сумма четных: 1378, нечетных: 1304`.
// Решение задачи №3(*)
// подготовленный массив
arrayOfNumbers
//print(arrayOfNumbers.compactMap {$0}.sorted())
func calculateSumEvenOddValues(from array: [Int?]) -> (Int, Int) {
    let newSet = Set(array).compactMap {$0} //  compactMap? Красавчик)))
    var sumEven: Int = 0 //Можно обе переменные в одной строке объявить и инициализировать сразу? А зачем?)) Так не надо делать, это ухудшает читабельность
    var sumOdd: Int = 0 // Опять с нэймингом тот же трабл
    for value in newSet {
        if value % 2 == 0 { sumEven += value }
        else { sumOdd += value }
    }
    //print(new_set.sorted())
    return (sumEven,sumOdd)
}

// проверка решения Задача №3
print(calculateSumEvenOddValues(from: arrayOfNumbers))


