//
//  MovieDetailBuilderTests.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MovieDetailBuilderTests: XCTestCase {
    
    var view: DetailsVC!
    var appFlowManager: AppFlowManager!
    
    override func setUp() {
        super.setUp()
        
        appFlowManager = AppFlowManager()
        let upComingMovies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
        view = appFlowManager.coordinateToDetailsVC(movie: upComingMovies.results?.first) as! DetailsVC
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
    }
    
    func testBuildViewModel() {
        XCTAssertTrue(view.viewModel != nil)
        
    }
    
    func testBuildVC() {
        XCTAssertTrue(view != nil)
    }
    
}
