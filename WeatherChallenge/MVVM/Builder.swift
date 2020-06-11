//
//  Builder.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

protocol Builder {
    associatedtype Built
}

extension Builder where Self.Built: ViewController, Self.Built.ViewModel: ViewModel {

    static func build(with dataSource: Built.ViewModel.DataSource) -> UIViewController {
        let viewController = Built.instantiate()
        let router = Built.ViewModel.Router.init(viewController: viewController as! Built.ViewModel.Router.ViewController)
        viewController.configure(with: Built.ViewModel(dataSource: dataSource, router: router))
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
}
