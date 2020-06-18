//
//  ApiResource.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 13/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

protocol ApiResource {
    associatedtype Model
    var urlRequest: URLRequest { get }
    func makeModel(fromData data: Data) throws -> Model
}

enum Endpoint {
    static var openWeatherMap: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        return urlComponents
    }
    static var ApiKey = "a9bb1e9a3d244628d33e07ebb7001c67"
}

extension ApiResource where Self.Model: Decodable {
    func makeModel(fromData data: Data) throws -> Model {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Model.self, from: data)
    }
}

extension ApiResource where Self.Model: EmptyNetworkResult {
    func makeModel(fromData data: Data) throws -> EmptyNetworkResult {
        return EmptyNetworkResult()
    }
}
