//
//  ViewModelDataSourceProtocol.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

protocol ViewModelDataSource {
    var context: Context { get }
}
