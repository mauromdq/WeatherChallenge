//
//  TableViewTests.swift
//  WeatherChallengeTests
//
//  Created by Mauro Sebastian Garcia on 18/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import XCTest
@testable import WeatherChallenge

class TableViewTests: XCTestCase {

    var viewControllerUnderTest: DailyViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "DailyViewController", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "DailyViewController") as? DailyViewController
        viewControllerUnderTest.loadView()
    }
    
    func testHasATableView() {
        let tableView = viewControllerUnderTest.weatherTableView
        XCTAssertNotNil(tableView)
    }
    
     func testTableViewHasOneSection() {
        let tableView = viewControllerUnderTest.weatherTableView
        let numberOfSections = tableView?.numberOfSections
        XCTAssertEqual(1, numberOfSections)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
    }
    
    override func tearDown() {        
        super.tearDown()
    }
}
