//
//  WeatherCell.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 14/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    private(set) var viewModel: WeatherCellViewModel!

    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var humLabel: UILabel!
    
    private var idDay: Int = 0
    private var dayInWeek: String = ""
    
    func configure(with viewModel: WeatherCellViewModel, id: Int) {
        self.viewModel = viewModel
        idDay = id + 1
        configure()
    }
    
    private func configure() {
        setDay()
        dayLabel.text = dayInWeek.capitalized
        viewModel.icon.bind(to: iconImage)
        viewModel.temp.bind(to: tempLabel)
        viewModel.hum.bind(to: humLabel)
    }
}

extension WeatherCell {
    func setDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = .init(identifier: "es_ES")
        let tomorrow = Date().addingTimeInterval(86400 * Double(idDay))
        dayInWeek = dateFormatter.string(from: tomorrow)
    }
}
