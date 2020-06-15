//
//  WeatherCellDataSource.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 14/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
struct WeatherCellDataSource: ViewModelDataSource {
    let context: Context
    var weather: Weather
}
