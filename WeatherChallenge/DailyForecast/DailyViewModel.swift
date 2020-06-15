//
//  DailyViewModel.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 14/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import Bond

class DailyViewModel: ViewModel {
    
    typealias DataSource = DailyDataSource
    typealias Router = DailyRouter
    
    private let router: DailyRouter
    private let context: Context
    let selectedCity: Observable<String?>
    private(set) var callEnded = Observable(false)
    var dailyWeather = Observable<DailyWeather?>(nil)
    let weatherList = Observable<[Weather]>([])
    var weathers = Observable<[WeatherCellDataSource]>([])
    
    required init(dataSource: DataSource, router: Router) {
        self.router = router
        context = dataSource.context
        selectedCity = dataSource.selectedCity
        _ = weathers.bind(signal: weatherList.toSignal().map { [weak self] weathers in
            guard let `self` = self else { return [] }
            return weathers.map {
                WeatherCellDataSource(context: self.context, weather: $0)
            }
        })
        callExternalService()
    }
    
    func callExternalService() {
        guard let city = selectedCity.value else { return }        
        context.apiService.getDailyWeather(cityName: city) { [weak self] (result) in
            guard let `self` = self else { return }
            //            self.router.hideLoadingIndicator()
            switch result {
            case .success(let weather):
                print(weather)
                self.dailyWeather.value = weather
                self.weatherList.value = weather.list
                self.callEnded.value = true
            case .failure:
                self.callEnded.value = true
                break
            }
        }
    }
}
