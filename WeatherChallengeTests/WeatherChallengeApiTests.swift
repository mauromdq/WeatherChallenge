//
//  WeatherChallengeTests.swift
//  WeatherChallengeTests
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import XCTest
@testable import WeatherChallenge

class WeatherChallengeApiTests: XCTestCase {
    
    let weatherApiService = MockApiService()

    func testGetCurrentWeather() {
        
        let expectation = self.expectation(description: "GetCurrentWeather Response Expectation")
        
        weatherApiService.shouldReturnError = false  //change to test Error
        
        weatherApiService.getCurrentWeather(cityName: "Shuzenji") { response in
                        
            if case .failure = response {
                XCTFail()
                return
            }
            
            do {
                let weather = try response.get()
                XCTAssertNotNil(weather)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetDailyWeather() {
        
        let expectation = self.expectation(description: "GetDailyWeather Response Expectation")
        
        weatherApiService.shouldReturnError = false  //change to test Error
        
        weatherApiService.getDailyWeather(cityName: "Shuzenji") { response in
                        
            if case .failure = response {
                XCTFail()
                return
            }
            
            do {
                let weather = try response.get()
                XCTAssertNotNil(weather)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
