//
//  DailyViewController.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 14/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import UIKit

class DailyViewController: UIViewController, ViewController {

    typealias ViewModel = DailyViewModel

    private var viewModel: DailyViewModel!
    private let activityView = UIActivityIndicatorView(style: .large)
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var cityLabel: UILabel!    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet private weak var weatherTableView: UITableView!
    
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
        _ = viewModel.dailyWeather.observeNext { [weak self] in
            guard let weather = $0 else { return }
            self?.cityLabel.text = weather.city.name
            self?.countryLabel.text = weather.city.country
        }
        _ = viewModel.weathers.bind(to: weatherTableView) { (weather, indexPath, tableView) -> UITableViewCell in            
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell            
            cell.configure(with: WeatherCellViewModel(dataSource: weather[indexPath.row]), id: indexPath.row)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            return cell
        }
    }
}

extension DailyViewController {
    func configUI() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        
        self.weatherTableView.delegate = self
        self.weatherTableView.separatorColor = .gray
        self.weatherTableView.tableFooterView = UIView()
        title = "Pronóstico extendido"
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
}

extension DailyViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  50
    }
}
