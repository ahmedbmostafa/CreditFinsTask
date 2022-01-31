//
//  MovieViewModelTests.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MovieViewModelTests: XCTestCase {

    var  dataProvider: MockMovieDataProvider!
    var  localDataManager: MockLocalDataManager!
    var  viewModel: MoviesViewModel!
    var  view = MockMovieVC()

    override func setUp() {
        super.setUp()

        dataProvider = MockMovieDataProvider()
        localDataManager = MockLocalDataManager()

        let coordinator = MoviesCoordinatorImpl(view: UIViewController())
        viewModel = MoviesViewModel(withDataProvider: dataProvider, andCoordinator: coordinator, localDataManager: localDataManager)

        dataProvider.delegate = viewModel
        view.viewModel = viewModel
        view.bindViewModelOutput()
    }

    override func tearDown() {
        super.tearDown()
        dataProvider = nil
        localDataManager = nil
        viewModel = nil
    }

    func testGetMoviesMethod() {

        dataProvider.closure = { [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
            self.dataProvider.delegate?.onSuccess(upcomingMovies)
        }

        viewModel.getUpcomingMovies()

        let cellViewModel = viewModel.getMovieListCellViewModel(index: 0)
        XCTAssert(cellViewModel.movieTitle == "Sing 2")
    }

    func testViewModelTableViewDidReachToEnd() {

        dataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
            self.dataProvider.delegate?.onSuccess(upcomingMovies)
        }

        viewModel.tableViewDidReachToEnd()

        let cellViewModel = viewModel.getMovieListCellViewModel(index: 0)
        XCTAssert(cellViewModel.movieTitle == "Sing 2")
    }

    func testViewModelOnTapOnCleartOrFavouriteFilter() {

        dataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
            self.dataProvider.delegate?.onSuccess(upcomingMovies)
        }

        viewModel.isFilteringActive = true
        viewModel.clearFilter()

        XCTAssert(viewModel.isFilteringActive == false)
    }

    func testViewModelDidSelectFavouriteFilter() {

        dataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
            self.dataProvider.delegate?.onSuccess(upcomingMovies)
        }

        viewModel.isFilteringActive = true
        viewModel.getUpcomingMovies()

        viewModel.didSelectFavorite { isEmpty in
            XCTAssert(self.viewModel.isFilteringActive == true)
            XCTAssert(self.localDataManager.isFavouriteMovieFetched == true)
        }
    }

    func testViewModelNumberOfRows() {

        dataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
            self.dataProvider.delegate?.onSuccess(upcomingMovies)
        }

        viewModel.getUpcomingMovies()
        viewModel.isFilteringActive = false

        XCTAssert(viewModel.numberOfMovies == 1)

    }

}
