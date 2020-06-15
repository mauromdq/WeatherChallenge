//
//  Weather.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 13/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let base: String?
    let cod: Int?
    let dt: Int
    let id: Int?
    let main: sMain
    let name: String?
    let sys: sSys
    let timezone: Int?
    let visibility: Int?
    let weather: [sWeather]
    let wind: sWind
}

struct sMain: Decodable {
    let feels_like: Double?
    let humidity: Int
    let pressure: Int
    let temp: Double
    let temp_max: Double?
    let temp_min: Double?
}

struct sSys: Decodable {
    let country: String?
    let id: Int?
    let sunrise: Int?
    let sunset: Int?
    let type: Int?
}

struct sWeather: Decodable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

struct sWind: Decodable {
    let deg: Int
    let speed: Double
}

