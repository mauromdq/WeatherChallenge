//
//  ApiService.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

protocol ApiServiceDelegate: class {
    func apiServiceDidRecieveUnauthorizedError(_ apiService: ApiService, retryHandler: @escaping () -> Void)
}

protocol ApiServiceProtocol {
    typealias GetWeatherHandler = (Result<Weather, Error>) -> Void
    func getCurrentWeather(cityName: String, then handler: @escaping GetWeatherHandler)
    typealias GetDailyWeatherHandler = (Result<DailyWeather, Error>) -> Void
    func getDailyWeather(cityName: String, then handler: @escaping GetDailyWeatherHandler)
}

class ApiService: ApiServiceProtocol {
    weak var delegate: ApiServiceDelegate?
    
    typealias GetWeatherHandler = (Result<Weather, Error>) -> Void
    
    func getCurrentWeather(cityName: String, then handler: @escaping GetWeatherHandler) {
        let resource = GetWeatherResource(cityName: cityName)
        let request = ApiRequest(resource: resource)
        perform(request: request, then: handler)
    }
    
    typealias GetDailyWeatherHandler = (Result<DailyWeather, Error>) -> Void

    func getDailyWeather(cityName: String, then handler: @escaping GetDailyWeatherHandler) {
        let resource = GetDailyWeatherResource(cityName: cityName)
        let request = ApiRequest(resource: resource)
        perform(request: request, then: handler)
    }
}

extension ApiService {
    func perform<Resource>(request: ApiRequest<Resource>, then handler: @escaping (Result<Resource.Model, Error>) -> Void) {
           request.load() { [unowned self] response in
               if case .failure(let error) = response, case NetworkError.serverError(code: let code, _) = error, code == 401 {
                   self.delegate?.apiServiceDidRecieveUnauthorizedError(self) { [weak self] in
                      self?.perform(request: request, then: handler)
                   }
               } else if case .failure(let error) = response, case NetworkError.serverError(code: let code, data: let data) = error, let errorData = data {
                       handler(.failure(error))
               } else {
                   handler(response)
               }
           }
       }
}
