//
//  CurrentRouter.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 12/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

import UIKit

class CurrentRouter: RouterProtocol {
    internal weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
