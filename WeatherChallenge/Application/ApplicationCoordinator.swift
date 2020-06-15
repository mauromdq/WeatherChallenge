//
//  ApplicationCoordinator.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 12/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: UITabBarController {
    private let apiService = ApiService()
    private lazy var persistenceController = PersistenceController()
    
//        : PersistenceController = {
//        PersistenceController(keyValueStorage: keyValueStorage)
//    }()
    private lazy var context: Context = {
        Context(apiService: apiService,
                persistenceController: persistenceController)
    }()
        
    func initialize(on window: UIWindow, _ application: UIApplication, and launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//        initialConfiguration()
        startApplication(on: window)
    }

    func startApplication(on window: UIWindow) {
        let navigationController = CustomNavigationController.navigationController()
        window.rootViewController = navigationController
        let mainViewController = MainBuilder.build(with: MainDataSource(context: context))
        let viewcontrollers = [mainViewController] //, navigationController.viewControllers.last!]
        navigationController.viewControllers = viewcontrollers
        navigationController.popViewController(animated: false)
    }
}
