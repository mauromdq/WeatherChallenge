//
//  MainRouter.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: RouterProtocol {
    internal weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToCurrent(dataSource: CurrentDataSource) {
        push(viewController: CurrentBuilder.build(with: dataSource))
    }

    func routeToDaily(dataSource: DailyDataSource) {
        push(viewController: DailyBuilder.build(with: dataSource))
    }
}
