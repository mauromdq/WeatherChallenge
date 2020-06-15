//
//  DailyRouter.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 14/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

class DailyRouter: RouterProtocol {
    internal weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
