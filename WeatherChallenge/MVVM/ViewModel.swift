//
//  ViewModel.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

protocol ViewModel: class {
    associatedtype DataSource: ViewModelDataSource
    associatedtype Router: RouterProtocol

    init(dataSource: DataSource, router: Router)
}

protocol ViewModelNotRouter: class {
    associatedtype DataSource: ViewModelDataSource

    init(dataSource: DataSource)
}
