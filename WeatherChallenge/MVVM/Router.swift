//
//  Router.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

protocol RouterProtocol {
    associatedtype ViewController: UIViewController
    var viewController: ViewController? { get }
    init(viewController: ViewController)
    func routeBack()
}

extension RouterProtocol {
   func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
