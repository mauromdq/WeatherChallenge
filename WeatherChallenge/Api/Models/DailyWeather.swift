//
//  DailyWeather.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 13/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

struct DailyWeather: Decodable {
    let cnt: Int
    let list: [Weather]
    let city: City
}

struct City: Decodable {
    let country: String
    let name: String
}
