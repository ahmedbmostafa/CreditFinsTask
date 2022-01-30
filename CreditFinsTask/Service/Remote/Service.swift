//
//  Service.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Alamofire

protocol MoviesServiceProtocol {
    func fetchMoviesList(page: Int, completion: @escaping (Result<UpComingMovies?, AFError>) -> Void)
}

class MoviesServiceImp: BaseAPI<EndPoint>, MoviesServiceProtocol {

    func fetchMoviesList(page: Int, completion: @escaping (Result<UpComingMovies?, AFError>) -> Void) {
        self.fetchMoviesList(target: .fetchMovies, page: page) { (result) in
            completion(result)
        }
    }
}
