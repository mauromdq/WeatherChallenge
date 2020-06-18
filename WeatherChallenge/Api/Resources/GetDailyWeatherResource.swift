//
//  GetDailyWeatherResource.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 13/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

class GetDailyWeatherResource: ApiResource {
    
    typealias Model = DailyWeather

    let urlRequest: URLRequest

    init(cityName: String? = nil) {
        var urlBuilder = Endpoint.openWeatherMap
        urlBuilder.path += "/data/2.5/forecast"
        urlBuilder.queryItems = [URLQueryItem(name: "q", value: "\(cityName!)"), URLQueryItem(name: "units", value: "metric"),
                                 URLQueryItem(name: "lang", value: "sp"), URLQueryItem(name: "cnt", value: "7"),
                                 URLQueryItem(name: "appid", value: Endpoint.ApiKey)]        
        guard let url = urlBuilder.url else { fatalError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        urlRequest = request
    }
}
