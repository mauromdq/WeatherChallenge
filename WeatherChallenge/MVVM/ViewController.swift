//
//  ViewController.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

protocol ViewController: UIViewController {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
    static func instantiate() -> Self
}

extension ViewController {
    static func instantiate() -> Self {
        UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as! Self
    }
}
