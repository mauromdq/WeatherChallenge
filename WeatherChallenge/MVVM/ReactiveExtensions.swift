//
//  ReactiveExtensions.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

public extension ReactiveExtensions where Base: UIView {

    func tapGesture(numberOfTaps: Int = 1, numberOfTouches: Int = 1) -> SafeSignal<UITapGestureRecognizer> {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = numberOfTaps
        gesture.numberOfTouchesRequired = numberOfTouches
        gesture.cancelsTouchesInView = true
        return addGestureRecognizer(gesture)
    }
}
