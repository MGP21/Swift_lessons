import UIKit

protocol CarProtocol { // Почему нет свойства, указывающего какому ДЦ принадлежит тачка? Получается один итот же экземпляр машины, может принадлежать разным ДЦ, что является парадоксом
    var model: String {get}
    var color: String {get}
    var buildDate: String {get}
    var price: Int {get set}
    var accessories: [String: Bool] {get set}
    var isServiced: Bool {get set}
}

protocol DealerhipProtocol {
    var name: String {get}
    var showroomCapacity: Int {get}
    var stockCars: [Car] {get set}
    var showroomCars: [Car] {get set}
    var cars: [Car] {get set}
    
    //func offerAccessories(_ : String...)
    func presaleService(_ : inout Car)
    func addToShowroom(_ : inout Car)
    func sellCar(_ : inout Car)
    func orderCar(_ : Car?) // В задаче указано что метод не принимает никаких параметров. Крайне странно заказывать любую машину.
}
extension DealerhipProtocol { //  вынес в расширение протокола, чтобы сделать функцию приватной
    private func offerAccessories(_ : String...) {}

}

struct Car: CarProtocol, Equatable {
    
    var model: String
    var color: String
    var buildDate: String
    var price: Int
    var accessories: [String: Bool]
    var isServiced: Bool
    static var existedCars: [Car] = [] // Массив, содержащий в себе все созданные экземпляры структуры
    
    init(model: String, color: String, buildDate: String, price: Int, accessories: [String: Bool], isServiced: Bool){
        self.model = model
        self.color = color
        self.buildDate = buildDate
        self.price = price
        self.accessories = accessories
        self.isServiced = isServiced
        Car.existedCars.append(self)
    }
}



class Dealer: DealerhipProtocol {
    var name: String
    var showroomCapacity: Int
    var stockCars: [Car]
    var showroomCars: [Car]
    var cars: [Car] = [] //В описании написано: хранит список всех машин в наличии. Что это значит? showroomCars + stockCars? и получается любую машину из cars можно продать или нет? Кажется самым правильным было бы складывать в массив ссылки на элементы массивов showroomCars и stockCars, но я хз как это сделать, что скажешь?
    var curCar: Car? //Дополнительная переменная, т.к. в offerAccessories нельзя передавать параметр Машина(car), а изменять его свойство надо

    init(name:String, showroomCapacity:Int, stockCars:[Car] = [], showroomCars:[Car] = []) {
        self.name = name
        self.showroomCapacity = showroomCapacity
        self.stockCars = stockCars
        self.showroomCars = showroomCars
        self.cars = showroomCars + stockCars
    }

    private func offerAccessories(_ accs: String...) {
        
        print("Вы выбрали установку дополнительной опции \(accs)")
        for item in accs {
            if curCar!.accessories.keys.contains(item) {
                if curCar!.accessories[item] == false {
                    curCar!.accessories[item] = true
                    print("Устанавливаем новую опцию \(item) ... ")
                }
                else { print("Опция \(item) уже установлена на авто") }
            }
            else { print("Извините, опция \(item) не доступна для этой модели авто ") }
        }
        print("Дополнительные опции на машине: \(curCar!.accessories)")
        
    }
    
    func presaleService(_ car: inout Car) {
        self.curCar = car
        print("\n")
        car.isServiced = true
        print("'\(car)' прошла предпродажную подготовку")
        print(car)
    }
    
    func addToShowroom(_ car: inout Car) {
        self.curCar = car
        print("\n")
        if stockCars.contains(car) {
            stockCars.dropFirst(stockCars.firstIndex(of: car)!)
            presaleService(&car)
            showroomCars.append(car)
            print("Машина \(car) перемещена со склада в шоурум '\(name)'")
        }
        else { print("Нельзя пригнать машину \(car) в шоурум '\(name)', т.к. её нет на складе") }
    }
    
    func sellCar(_ car: inout Car) {
        print("\n SELL CAR")
        if cars.contains(car) {
            curCar = car
            let carIndexInCars = cars.firstIndex(of: car)
            
            offerAccessories("toning", "sport rims", "car alarm")
            cars[carIndexInCars!] = curCar! //Изменили сам экземпляр машины, т.к. в offerAccessories работаем с curCar
            print("Проверка предпродажной подготовки...")
            if curCar!.isServiced == true {
                print("Предпродажная подготовка \(curCar!) уже выполнена.")
                print("CARS: ", cars)
                if stockCars.contains(car) { stockCars.remove(at: stockCars.firstIndex(of: car)!) }
                else { showroomCars.remove(at: showroomCars.firstIndex(of: car)!) }
                print("Машина \(curCar!) продана клиенту! Поздравляем!")
            }
            else { print("Машина \(curCar!) еще не прошла предпродажную подготовку. Чтобы продать машину сначала выполниту эту процедуру.")  }
        }
        else { print("Выбранной машины \(curCar!) нет у диллера '\(name)'") }
        print(cars.count)
        cars = showroomCars + stockCars
        
    }
    
    func orderCar(_ bibika: Car? = nil) {
        print("\n ORDER CAR")
        if bibika == nil {
            var diff: [Car] = [] // Содержит только те машины, которые были созданы, но не было добавлены е текущему дилерскому центру
            for car in Car.existedCars {
                if cars.contains(car) == false {
                    diff.append(car)
                }
            }
            
            if diff.isEmpty == false {
                let randCar = diff.randomElement()
                stockCars.append(randCar!)
                print("\(randCar!.model) была добавлена на парковку дилерского центра '\(name)'")
            }
            else { print("На заводе нет новых машин") } // нет экземпляров Car, не добавленных в текущий ДЦ
        }
        else { // На тот случай, если мы одумаемся и будем знать, какую машину заказать. Правда тут вновь всплывает проблема отсутвия 
            stockCars.append(bibika!)
            print("\(bibika!) была добавлеа на парковку дилерского центра '\(name)'")
        }
        cars = showroomCars + stockCars
        print(cars.count)
    }
    
    
}



//Проверка
var bmw_x6 = Car(model: "BMW X6", color: "Black", buildDate: Date().description, price: 100, accessories: ["toning": true, "sport rims": true, "car alarm": false], isServiced: true)
var honda_pilot = Car(model: "Honda Pilot", color: "Gray", buildDate: Date().description, price: 70, accessories: ["toning": false, "sport rims": false, "car alarm": false], isServiced: false)
var audi_a6 = Car(model: "Audi A6", color: "Red", buildDate: Date().description, price: 100, accessories: ["toning": true, "sport rims": true, "car alarm": true], isServiced: false)
var lexus_is300 = Car(model: "Lexus IS300", color: "White", buildDate: Date().description, price: 90, accessories: ["toning": false, "sport rims": true, "car alarm": false], isServiced: false)
var volvo_xc69 = Car(model: "Volvo XC 60", color: "Black", buildDate: Date().description, price: 110, accessories: ["toning": false, "sport rims": false, "car alarm": true], isServiced: false)

print(bmw_x6)
let bmwDealer = Dealer(name: "BmwDC", showroomCapacity: 10)
let honDealer = Dealer(name: "HondaDC", showroomCapacity: 10)
let audiDealer = Dealer(name: "AudiDC", showroomCapacity: 10)

print(Car.existedCars)
print(bmwDealer.cars)
bmwDealer.orderCar(bmw_x6)
bmwDealer.sellCar(&bmw_x6)
print("\n")
print(bmwDealer.cars)
print("\n")





