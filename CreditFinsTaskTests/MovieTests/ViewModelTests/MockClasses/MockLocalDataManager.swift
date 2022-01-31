//
//  MockLocalDataManager.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MockLocalDataManager: LocalDataManagerProtocol {

    var isFavouriteMovieFetched = false
    var isFavouriteMovieSaved = false
    var isFavouriteMovieDeleted = false
    var entity = "FavouriteMovies"

    func retrieveFavouriteMovies(completion: @escaping ([FavouriteMovies]) -> ()) {
        isFavouriteMovieFetched = true
    }

    func savePost(dataDic: [String : Any]) {
        isFavouriteMovieSaved = true
    }

    func deleteObjectFromCD(entity: String, withID: String) {
        isFavouriteMovieDeleted = true
    }



}
