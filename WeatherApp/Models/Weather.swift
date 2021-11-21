//
//  Weather.swift
//  WeatherApp
//
//  Created by Natthaporn Wimonanupong on 17/11/2564 BE.
//

import Foundation

struct WeatherResponse: Decodable {
    var lat: Double
    var lon: Double
    var current: currentStatue
    var hourly: [Weather]
    var daily: [dailyStatus]
}

struct Weather: Decodable, Identifiable {
    var id: UUID?
    var dt: Double
    var temp:Double
    var weather: [hourlyStatue]
}

// hour
struct hourlyStatue: Decodable{
    var description: String
}

//current
struct currentStatue: Decodable{
    var dt: Double
    var temp:Double
    var uvi: Double
    var sunrise: Double
    var sunset: Double
    var weather: [hourlyStatue]
}

//daily
struct dailyStatus: Decodable{
    var dt: Double
    var sunrise: Double
    var sunset: Double
    var temp: Temp
    var weather: [eachday]
}

struct Temp: Decodable{
    var day, min, max: Double
}

struct eachday: Decodable{
    var description: String
}

//struct weatherdaily: Decodable {
//    var weatherday: [hourlyStatue]
//}

