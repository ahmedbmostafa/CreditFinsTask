//
//  MockMoviesViewModel.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask
import UIKit

class MockMoviesViewModel: MoviesViewModelProtocol{

    var dataProvider: MovieDataProviderProtocol!
    var coordinator: MoviesCoordinatorProtocol!

    var isNumberOfRowsCalls = false
    var isGetMovieCellViewModelCalls = false
    var isDidSelectRowCalls = false

    var numberOfMovies: Int {
        isNumberOfRowsCalls = true
        return 1
    }

    var output: MoviesViewModelOutput?

    func getMovieListCellViewModel(index: Int) -> MovieTableViewCellViewModel {
        isGetMovieCellViewModelCalls = true
        let movies = try! JSONDecoder().decode(UpComingMovies.self, from: movieStub)
        return MovieTableViewCellViewModel(movies.results?.first )
    }

    func didSelectMovie(index: Int) {
        isDidSelectRowCalls = true
    }

    func didLoad() {

    }

    func tableViewDidReachToEnd() {

    }

    func didSelectFavorite(completion: @escaping (Bool) -> ()) {

    }

    func clearFilter() {
        
    }





}
