//
//  MockApiService.swift
//  WeatherChallengeTests
//
//  Created by Mauro Sebastian Garcia on 17/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
@testable import WeatherChallenge

class MockApiService{
    var shouldReturnError = false
    var getCurrentWeatherCalled = false
    var getDailyWeatherCalled = false
 
    enum MockServiceError: Error {
        case currentWeather
        case dailyWeather
    }
    
    func reset() {
        shouldReturnError = false
        getCurrentWeatherCalled = false
        getDailyWeatherCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let mockGetCurrentResponse =  Weather(base: "",
                                          cod: 200,
                                          dt: 1560350192,
                                          id: 1851632,
                                          main: sMain(feels_like: 27.99, humidity: 93, pressure: 1016, temp: 28.52, temp_max: 28.71, temp_min: 280.15),
                                          name: "Shuzenji",
                                          sys: sSys(country: "JP", id: 2019346, sunrise: 1560281377, sunset: 1560333478, type: 3),
                                          timezone: 32400,
                                          visibility: 16093,
                                          weather: [sWeather(description: "clear sky", icon: "01n", id: 800, main: "Clear")],
                                          wind: sWind(deg: 107, speed: 0.47)
                                        )
        
    let mockGetDailyResponse =  DailyWeather(cnt: 2,
                                             list: [Weather(base: "",
                                                        cod: 200,
                                                        dt: 1560350192,
                                                        id: 1851632,
                                                        main: sMain(feels_like: 27.99, humidity: 93, pressure: 1016, temp: 28.52, temp_max: 28.71, temp_min: 28.15),
                                                        name: "Shuzenji",
                                                        sys: sSys(country: "JP", id: 2019346, sunrise: 1560281377, sunset: 1560333478, type: 3),
                                                        timezone: 32400,
                                                        visibility: 16093,
                                                        weather: [sWeather(description: "clear sky", icon: "01n", id: 800, main: "Clear")],
                                                        wind: sWind(deg: 107, speed: 0.47)),
                                                    Weather(base: "",
                                                        cod: 200,
                                                        dt: 1560351123,
                                                        id: 1851878,
                                                        main: sMain(feels_like: 22.29, humidity: 62, pressure: 416, temp: 23.23, temp_max: 26.57, temp_min: 20.11),
                                                        name: "Shuzenji",
                                                        sys: sSys(country: "JP", id: 2019346, sunrise: 1560281377, sunset: 1560333478, type: 3),
                                                        timezone: 32400,
                                                        visibility: 16093,
                                                        weather: [sWeather(description: "overcast clouds", icon: "04d", id: 804, main: "Clouds")],
                                                        wind: sWind(deg: 211, speed: 5.27)),
                                                        ],
                                             city: City(country: "JP", name: "Shuzenji"))
}

extension MockApiService: ApiServiceProtocol {
    func getCurrentWeather(cityName: String, then handler: @escaping GetWeatherHandler) {
        getCurrentWeatherCalled = true
        
        if shouldReturnError {
            handler(.failure(MockServiceError.currentWeather))
        } else {
            handler(.success(mockGetCurrentResponse))
        }
    }
    
    func getDailyWeather(cityName: String, then handler: @escaping GetDailyWeatherHandler) {
        getDailyWeatherCalled = true
        
        if shouldReturnError {
            handler(.failure(MockServiceError.dailyWeather))
        } else {
            handler(.success(mockGetDailyResponse))
        }
    }
    
    
}
