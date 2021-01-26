import UIKit
//https://github.com/netology-code/bios-homeworks/tree/master/4.5
/* Задача №1:
 Вам нужно реализовать перечисление "Телевизионный канал" с 5-7 каналами.

 Алгоритм выполнения
 1. Реализуйте класс "Телевизор". У него должны быть состояния:
  - фирма/модель (реализовать одним полем);
  - включен/выключен;
  - текущий телеканал.
 У него должно быть поведение:
 - показать, что сейчас по телеку.
 2. Вызовите метод и покажите, что сейчас по телеку.
 3. Сделайте изменение состояний телевизора (на свой выбор).
 4. Повторите вызов метода и покажите, что сейчас по телеку.
 
 Задача №2:
 1. Реализуйте структуру настроек:
    - громкость (от 0 до 1; подумайте, какой тип использовать);
    - показывать цветом или черно-белым (подумайте, какой тип данных лучше всего использовать).
 2. Интегрируйте Настройки в класс Телевизор.
 */

class Tv {
    let brandModel: String
    var state: Bool
    var currentChannel: Int // сокращать плохо, так нельзя !FIXED!

    init(brandModel: String, state: Bool, currentChannel: Int) {
        self.brandModel = brandModel
        self.state = state
        self.currentChannel = currentChannel
    }
    struct Settings {
        var volume: Double = 0.3
        var showColor: Bool = false
    }
    
    var conf = Settings() // не сокращай плз. Че букв жалко что ли)) Должно быть написано так, чтобы через год ты открыл и сразу понял что ты имел в виду:)
    func changeSettings(vol: Double? = nil, color: Bool? = nil){
        //if vol != nil && color == nil
        if let volume = vol, color == nil { // if let volume = vol, color == nil ... Кажется так будет лучше и не надо будет анврапить !FIXED!
            conf.volume = volume
            print("Change volume to \(conf.volume)")
        }
        else if color != nil && vol == nil {
            conf.showColor = color!
            print("Change color mode to \"show color \(conf.showColor)\"")
        }
        else if color != nil && vol != nil {
            conf.showColor = color!
            conf.volume = vol!
            print("Change color mode to \"show color \(conf.showColor)\" and volume to \(conf.volume)")
        }
        else {print("Please fill one parameter at least: color mode or/and volume")} // по поводу такого я писал уже
        //print("Settings now: volume = \(conf.volume), showColor is \(conf.showColor)")
    }
    
    func showCurrentChannel() {
        print("Current channel is: \(currentChannel)")
    }
    
}

let tv1 = Tv (brandModel: "Samsung", state: true, currentChannel: 5)
tv1.showCurrentChannel()
tv1.changeSettings(vol: 0.5, color:true)


/* Задача 3:
 Алгоритм выполнения
 1. Создайте перечисление со связанными значениями с двумя кейсами:
    - телеканал;
    - подключение по входящему видео порту.
 2. Интегрируйте эту опцию в Телевизор (используйте наследование). ??? Каким образом интегрировать? ну вот так и интегрировать, как ты сделал. Отнаследоваться и переопределить
 3. Вызовите метод и покажите, что сейчас по телевизору.
 */

class Tv2: Tv { // Пробел перед Tv !FIXED!
    
    enum Controller{
        case channel(Int)
        case videoInPort(Bool)
    }
    
    override var currentChannel: Int {
        get { return super.currentChannel}
        set(channel) { // можно вот так не задавать название. У set {} есть всегда newValue
            super.currentChannel = channel
        }
    }
        
    func changeState(ch: Int? = nil, videoIn: Bool? = nil){
        if ch == nil && videoIn != nil {
            let video = Controller.videoInPort(videoIn!)
            handleState(control: video)
        }
        else if videoIn == nil && ch != nil {
            let channel = Controller.channel(ch!)
            handleState(control: channel)
        }
        else {print("Please fill one parameter: channel number or video connection")}
    }
    
    private func handleState(control: Controller){
        switch control {
        case let .channel(ch):
            currentChannel = ch
            print("Channel was swith to \(currentChannel)")
        case let .videoInPort(videoIn):
            print("Connection using video port: \(videoIn)")
        }
    }
    
//    func changeState(ch: Int? = nil, videoIn: Bool? = nil){
//        var control: Controller
//        if ch == nil {control = Controller.videoInPort(videoIn!)}
//        else {control = Controller.channel(ch!)}
//        switch control {
//        case let .channel(ch):
//            cur_ch = ch
//            print("Channel was swith to \(cur_ch)")
//        case let .videoInPort(videoIn):
//            print("Connection using video port: \(videoIn)")
//        }
//    }
        
}

let tv2 = Tv2(brandModel: "Sony", state: false, currentChannel: 4)
tv2.changeState(ch: 5)
tv2.showCurrentChannel()
tv2.changeState(videoIn: true)
tv2.changeState(ch: 6, videoIn: true) //
tv2.changeSettings()
