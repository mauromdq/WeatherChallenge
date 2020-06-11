//
//  Context.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

final class Context {
    private let apiService: ApiService
    private let persistenceController: PersistenceController

    init(apiService: ApiService, persistenceController: PersistenceController) {
        self.apiService = apiService
        self.persistenceController = persistenceController
    }
}
