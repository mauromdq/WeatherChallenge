//
//  CustomNavigationController.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 12/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    static func navigationController() -> CustomNavigationController {
        let navController = CustomNavigationController()
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.tintColor = .black
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
        ]
        navController.navigationBar.titleTextAttributes = textAttributes
        navController.navigationBar.backItem?.title = "Volver"
        navController.delegate = navController
        return navController
    }
}
