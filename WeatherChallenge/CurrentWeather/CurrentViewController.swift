//
//  CurrentViewController.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 12/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

class CurrentViewController: UIViewController, ViewController {

    typealias ViewModel = CurrentViewModel

    private var viewModel: CurrentViewModel!
    private let activityView = UIActivityIndicatorView(style: .large)
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var detailStackview: UIStackView!
    @IBOutlet private weak var minLabel: UILabel!
    @IBOutlet private weak var maxLabel: UILabel!
    @IBOutlet private weak var pressLabel: UILabel!
    @IBOutlet private weak var humLabel: UILabel!
    
    private var myString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindSetting()
    }
            
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func bindSetting() {
        _ = viewModel.callEnded.observeNext { [weak self] in
            if $0 {
                self?.contentView.isHidden = false
                self?.hideActivityIndicatory()
            } else {
                self?.contentView.isHidden = true
                self?.showActivityIndicatory()
            }
        }
        _ = viewModel.weather.observeNext { [weak self] in
            guard let weather = $0 else { return }
            self?.iconImage.image = self?.setIconImage(type: weather.weather[0].main)
            self?.cityLabel.text = weather.name
            let tmp = String(Int(weather.main.temp))
            self?.tempLabel.text = tmp + "º"
            self?.descLabel.text = weather.weather[0].description.capitalized
            if let min = weather.main.temp_min {
                self?.minLabel.attributedText = self?.myString.setTextLabel(title: "Min:  ", text: String(min))
            } else {
                self?.minLabel.attributedText = self?.myString.setTextLabel(title: "Min:  ", text: "---")
            }
            if let max = weather.main.temp_max {
                self?.maxLabel.attributedText = self?.myString.setTextLabel(title: "Max:  ", text: String(max))
            } else {
                self?.maxLabel.attributedText = self?.myString.setTextLabel(title: "Max:  ", text: "---")
            }
            let hm = String(weather.main.humidity)
            self?.pressLabel.attributedText = self?.myString.setTextLabel(title: "Presión:  ", text: String(weather.main.pressure))
            self?.humLabel.attributedText = self?.myString.setTextLabel(title: "Humedad:  ", text: hm + "%")
        }
    }
}

extension CurrentViewController {
    func configUI() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        title = "Clima actual"
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func showActivityIndicatory() {
        activityView.startAnimating()
    }

    func hideActivityIndicatory() {
        activityView.stopAnimating()
    }
    
    func setIconImage(type: String) -> UIImage {
        let icon: UIImage
        switch type {
        case "Clear":
            icon = #imageLiteral(resourceName: "sun2")
        case "Clouds":
            icon = #imageLiteral(resourceName: "sun1")
        case "Rain":
            icon = #imageLiteral(resourceName: "rain.png")
        case "Snow":
            icon = #imageLiteral(resourceName: "snow.png")
        default:
            icon = #imageLiteral(resourceName: "sun1")
        }
        return icon
    }
}
