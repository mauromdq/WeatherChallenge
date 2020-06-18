//
//  CurrentViewModel.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 12/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import Bond

class CurrentViewModel: ViewModel {
    
    typealias DataSource = CurrentDataSource
    typealias Router = CurrentRouter

    private let router: CurrentRouter
    private let context: Context
    let selectedCity: Observable<String?>
    private(set) var callEnded = Observable(false)
    var weather = Observable<Weather?>(nil)
    
    required init(dataSource: DataSource, router: Router) {
        self.router = router
        context = dataSource.context
        selectedCity = dataSource.selectedCity
        callExternalService()
    }
    
    func callExternalService() {
        guard let city = selectedCity.value else { return }
        context.apiService.getCurrentWeather(cityName: city) { [weak self] (result) in        
            guard let `self` = self else { return }            
            switch result {
            case .success(let weather):                
                self.weather.value = weather
                self.callEnded.value = true
            case .failure:
                self.callEnded.value = true
                break
            }
        }
    }
}
