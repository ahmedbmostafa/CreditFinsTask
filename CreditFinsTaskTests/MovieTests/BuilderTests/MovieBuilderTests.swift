//
//  MovieBuilderTests.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 30/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MovieBuilderTests: XCTestCase {

    var view: MovieVC!
    var appFlowManager: AppFlowManager!

    override func setUp() {
        super.setUp()
        appFlowManager = AppFlowManager()
        view = appFlowManager.creatMovieVC() as! MovieVC
    }

    override func tearDown() {
        super.tearDown()
        view = nil
    }

    func testBuildViewModel() {
        XCTAssertTrue(view.viewModel != nil)
        XCTAssertTrue(view.viewModel.coordinator != nil)
        XCTAssertTrue(view.viewModel.dataProvider != nil)

    }

    func testBuildVC() {
        XCTAssertTrue(view != nil)
    }

}
