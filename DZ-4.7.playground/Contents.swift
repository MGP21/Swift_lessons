import UIKit

/*
 https://github.com/netology-code/bios-homeworks/tree/master/4.7
 Задание 1:
 Алгоритм выполнения:
 - Создайте суперкласс артист;
 - Определите в нем общие для артиста свойства (имя, страна, жанр);
 - Определите общие методы (написать трек и исполнить трек);
 - В реализацию метода "написать трек" добавьте вывод в консоль "Я (имя артиста) написал трек (название трека)";
 - В реализацию метода "исполнить трек" добавьте вывод в консоль "Я (имя артиста) исполнил трек (название трека)";
 - Создайте 3 сабкласса любых артистов и переопределите в них свойства суперкласса класса.
 
 Задание 2: Создание списка артистов.
 Алгоритм выполнения:
 - Доработайте существующих артистов так, чтобы они имели уникальные для каждого из них свойства и методы.
- Защитите этих артистов от редактирования в будущем.
 
 Задание 3:
 Алгоритм выполнения:
 - Создайте пустой массив, чтобы потом добавить в него ваших артистов;
 - Добавьте созданных ранее артистов в массив;
 */



class Artist:CustomStringConvertible {
    var description: String { return "\(name)"}
    var info: String {return "Name: \(name), Country: \(country), Genre: \(genre)"}
    var name, country, genre: String
    var tracks:[String] = []
    //var description: String { return "Name: \(name), "}
    init (name:String, country: String, genre: String) {
        self.name = name
        self.country = country
        self.genre = genre
    }
    
    func makeTrack(track_name:String){
        tracks.append(track_name)
        print("Я, \(self.name), написал трек '\(track_name)'")
    }
    
    func playTrack(track_name: String){
        if tracks.contains(track_name) == true {
            print("Я, \(self.name), исполнил трек '\(track_name)'")
        }
        else {
            print("Sorry я,\(self.name), не знаю трек '\(track_name)'")
        }
    }
} // close class Artist

class PopArtist: Artist {
    init(name: String, country: String){
        super.init(name: name, country: country, genre: "Pop")
    }
}

final class RussianArtist: Artist {
    override var info: String { return "Это российский артист и его зовут \(name)" }
    init() {
        super.init(name: "Иван", country: "Russia", genre: "Hip-Hop")
    }
}


final class CinemaArtist: Artist {
    var movie_genre = "Comedy"
    func showPerfomance(){
        print("\(name) показывает сцену из кино")
    }
}

let usual_artist = Artist(name: "Kostya", country: "Russia", genre: "lyric")
print(usual_artist)
usual_artist.makeTrack(track_name: "Новая песня")

let maroon5 = PopArtist(name: "Maroon5", country: "USA")
print(maroon5)

let rus_artist = RussianArtist()
print(rus_artist)
rus_artist.playTrack(track_name: "Русская народная")

let movie_artist = CinemaArtist(name: "Крис Рок", country: "USA", genre: "StandUp")
movie_artist.showPerfomance()

var artists = [Any]()
artists.append(usual_artist)
//artists.append(contentsOf: [maroon5, rus_artist, movie_artist])
print(artists)
