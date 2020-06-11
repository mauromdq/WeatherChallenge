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

class ApiService {
    weak var delegate: ApiServiceDelegate?
}

extension ApiService {
}
