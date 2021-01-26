import UIKit

//https://github.com/netology-code/bios-homeworks/tree/master/4.6
/*
 Задача 1
 Вы разрабатываете библиотеку аудио треков. Вам необходимо реализовать одну из категорий музыки, наполненную треками.

 Алгоритм выполнения:
 1. Создайте объект трек
 2. Определите в нем свойства имя, исполнитель, длительность и страна
 3. Создайте класс категория
 4. Объявите в нем свойства название категории, список треков и количество треков в списке (экспериментируйте с "ленивыми" и вычисляемыми свойствами)
 5.Определите методы добавления и удаления треков в эту категорию
 */

struct Track: CustomStringConvertible {
    let name, artist, country: String
    let duration: Int
    var in_category: Category?
    public var info: String { return """
                                TRACK ⎡ Name: \(name),
                                      ⎜ Artist: \(artist),
                                      ⎜ Country: \(country),
                                      ⎜ Duration: \(duration),
                                      ⎣ In category: \(in_category) \n
                            """}
    public var description: String { return "\"\(name)\"" }
}

class Category: CustomStringConvertible {
    let category_name : String
    lazy var tracklist: [Track] = []
    static var categories = [Category]()
    
    init(category_name: String) {
        self.category_name = category_name
        //self.tracklist = []
        Category.categories.append(self) // массив со всеми экзепмлярами Категорий
    }
    
    func addTrack(track: inout Track) { // Несмотря на то, что trackset - множество, почему то попытка добавления одинаковых треков не вызывает ошибку
        if tracklist.contains(where: {$0.name == track.name}) { print("\(track) is already in category \"\(category_name)\"") }
        else {
            tracklist.append(track)
            print("Track \"\(track.name)\" added to \(category_name)")
            track.in_category = self
            }

    }
    
    func delTrack(track: inout Track ) {
        if tracklist.isEmpty == true { print ("Can't remove '\(track)': category \(category_name) is empty")}
        else {
            if tracklist.contains(where: { $0.name == track.name }) { // ХЗ почему так не сработало, но я уже тут подзапутался чуток.
                for item in tracklist {
                    if item.name == track.name {
                        if let i = tracklist.firstIndex(where: {$0.name == item.name }) {
                            track.in_category = nil
                            //print(tracklist[i].info)
                            tracklist.remove(at: i)
                            print("Track \"\(item.name)\" removed from '\(category_name)'")
                        }
                        else { print("\"\(track)\" not in category '\(category_name)'")}
                    }
                }
            }
            else { print("Can't remove \(track) because category '\(category_name)' doesn't contains it")}
        }
    }
    
    public var description: String { return "\"\(category_name)\""}
} //close class

/*
 Задача 2:
 Доработайте свою библиотеку так, чтобы в ней было несколько категорий

 Алгоритм выполнения:
 Создайте класс библиотеки. Этот класс будет аналогичен классу категории, только хранить он должен список категорий
 */

/*
 Задача 3:
 Преобразуйте классы так, чтобы в пределах вашей библиотеки можно было обмениваться треками между категориями
 */


class Library { // Он тоже должен иметь методы добавления/удаления в него категорий???
    let library_name: String
    //var categories: [String] = []
    var categories_count: Int
    var categories = Category.categories
    
    init (library_name: String) {
        self.library_name = library_name
        self.categories_count = categories.count
    }
    
    func changeTrackCategory(track: inout Track, to_category: Category){
        let current_track_category = track.in_category
        if  current_track_category?.category_name == to_category.category_name { print("\(track) is already in category \(to_category)") }
        else {
            if categories.contains(where: { $0.category_name == to_category.category_name }) { // Проверяем что категория в которую хотим переместить трек в нашей библиотеке
                current_track_category?.delTrack(track: &track)
                to_category.addTrack(track: &track)
            }
            else { print("\(to_category.category_name) not in libraty \"\(library_name)\"") }
        }
    }
    
    func delCategoryFromLib(category: Category) {
        let position = categories.firstIndex(where: { $0.category_name == category.category_name})
        if position != nil {
            categories.remove(at: position!)
        }
        else { print("\(category.category_name) is not in library") }
    }
}


//Выполнение
var track1 = Track(name: "Till It's Gone", artist: "Yelawolf", country: "Austalia", duration: 250)
var track2 = Track(name: "Taro", artist: "Alt-J", country: "USA", duration: 200)

let old_music = Category(category_name: "Old Music")
let modern_music = Category(category_name: "Modern Music")

print("\(old_music) has \(old_music.tracklist.count) tracks")

old_music.delTrack(track: &track2)
old_music.addTrack(track: &track1)
print(track1.info)
print(track2.info)

old_music.addTrack(track: &track2)
print(track2.info)
print("\(old_music) tracklist: \(old_music.tracklist)")
old_music.delTrack(track: &track2)
print(track2.info)
print("\n")

print("\(old_music) tracklist: \(old_music.tracklist)")
old_music.delTrack(track: &track2)
print("\n")

let newLibrary = Library(library_name: "My Music")
print(newLibrary.categories)
newLibrary.changeTrackCategory(track: &track2, to_category: modern_music)
print(track2.info)
print("\(old_music) tracklist: \(old_music.tracklist)")

