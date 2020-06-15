//
//  WeatherCellViewModel.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 14/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import Bond

class WeatherCellViewModel: ViewModelNotRouter {

    typealias DataSource = WeatherCellDataSource
        
    var icon = Observable<UIImage?>(nil)
    var temp: Observable<String?>
    var hum: Observable<String?>
    let iconId: String
    
    required init(dataSource: WeatherCellDataSource) {
        iconId = dataSource.weather.weather[0].main
        let tmp = String(Int(dataSource.weather.main.temp))
        temp = Observable(tmp + "º")
        let hm = String(Int(dataSource.weather.main.humidity))
        hum = Observable("h:" + hm + "%")
        icon.value = setIcon(type: iconId)        
    }
    
    func setIcon(type: String) -> UIImage {
        var icon = UIImage()
        switch type {
        case "Clear":
            icon = #imageLiteral(resourceName: "sun2")
        case "Clouds":
            icon = #imageLiteral(resourceName: "sun1")
        case "Rain":
            icon = #imageLiteral(resourceName: "rain.png")
        case "Snow":
            icon = #imageLiteral(resourceName: "snow.png")
        default:
            icon = #imageLiteral(resourceName: "sun1")
        }
        return icon
    }
}
