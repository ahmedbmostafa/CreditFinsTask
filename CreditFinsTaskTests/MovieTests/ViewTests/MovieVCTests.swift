//
//  MovieVCTests.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MovieVCTests: XCTestCase {

    var  viewModel: MockMoviesViewModel!
    var  localDataManager: MockLocalDataManager!
    var  view: MovieVC!
    let mockTableView = UITableView()

    override func setUp() {
        super.setUp()
        viewModel = MockMoviesViewModel()
        localDataManager = MockLocalDataManager()
        view = MovieVC.instantiate(fromAppStoryboard: .Main)
        view.viewModel = viewModel
        view.loadView()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        view = nil
    }

    func testNumberOfRowsInSection() {
        _ = view.tableView(view.tableView, numberOfRowsInSection: 1)
        XCTAssertTrue(viewModel.isNumberOfRowsCalls == true)
    }

    func testCellDidSelectForRowAtIndex() {
        let indexPath = IndexPath(row: 0, section: 1)
        view.tableView(view.tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(viewModel.isDidSelectRowCalls == true)
    }

    func testSaveCoreData(){
        let indexPath = IndexPath(row: 0, section: 1)
        _ = view.tableView(view.tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
        let dict = ["id":"1"]
        localDataManager.savePost(dataDic: dict)
        XCTAssert(localDataManager.isFavouriteMovieSaved == true)
    }

    func testDeleteCoreData(){
        let indexPath = IndexPath(row: 0, section: 1)
        _ = view.tableView(view.tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
        let id = "1"
        localDataManager.deleteObjectFromCD(entity: localDataManager.entity, withID: id)
        XCTAssert(localDataManager.isFavouriteMovieDeleted == true)
    }

}
