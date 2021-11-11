//
//  WeatherModel.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 10/11/21.
//

import Foundation
struct WeatherModel: Decodable{
    let coord: Coord?
    let weather: [Weather?]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Coord : Decodable{
    let lon: Float?
    let lat: Float?
}

struct Weather: Decodable{
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Decodable{
    let temp: Float?
    let feels_like: Float?
    let temp_min: Float?
    let temp_max: Float?
    let pressure: Int?
    let humidity: Int?
    let sea_level: Int?
    let grnd_level: Int?
}

struct Wind : Decodable{
    let speed: Float?
    let deg : Int?
    let gust : Float?
}

struct Gust: Decodable{
    let all: Int?
}

struct Sys : Decodable{
    let country : String?
    let sunrise : Int?
    let sunset : Int?
}
