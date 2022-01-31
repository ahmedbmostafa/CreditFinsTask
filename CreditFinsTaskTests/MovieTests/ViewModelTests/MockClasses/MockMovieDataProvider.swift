//
//  MockMovieDataProvider.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MockMovieDataProvider: MovieDataProviderProtocol {

    var delegate: MovieDataProviderDelegate?

    var closure: (() -> ())?

    func fetchUpcomingMovies() {
        closure?()
    }
}
