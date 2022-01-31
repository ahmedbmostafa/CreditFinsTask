//
//  DetailsViewModelTests.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class DetailsViewModelTests: XCTestCase {

    var  viewModel: DetailsViewModelProtocol!
    var  view = MockMovieDetailVC()
    
    override func setUp() {
        super.setUp()
        let upcomingMovies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
        viewModel = DetailsViewModel(upcomingMovies.results?.first)
        view.viewModel = viewModel
        view.bindViewModelOutput()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testViewDidLoad() {

        viewModel.didLoad()

        XCTAssertTrue(view.isMovieImageView == true)
        XCTAssertTrue(view.isShowMovieTitle == true)
        XCTAssertTrue(view.isShowMovieReleaseDate == true)
        XCTAssertTrue(view.isShowMovieDescription == true)
        XCTAssertTrue(view.isShowMovieVoteAverage == true)
        XCTAssertTrue(view.isShowMoviePopulaity == true)


    }


}
