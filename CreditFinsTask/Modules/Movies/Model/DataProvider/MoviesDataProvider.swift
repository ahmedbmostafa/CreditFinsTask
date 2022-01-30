//
//  MoviesDataProvider.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Foundation
import Alamofire

protocol MovieDataProviderDelegate: class {
    func onSuccess(_ upcomingMovies: UpComingMovies)
    func onFailure(_ error: AFError)
    func showLoader(show: Bool)
}

protocol MovieDataProviderProtocol {
    func fetchUpcomingMovies()
    var delegate: MovieDataProviderDelegate? { get set }
}

class MovieDataProviderImpl: MovieDataProviderProtocol {

    var movieService: MoviesServiceProtocol!

    private var pageCount = 1
    private var totalPages: Int = 1
    private var isFetching = false

    weak var delegate: MovieDataProviderDelegate?

    func fetchUpcomingMovies() {

        if pageCount <= totalPages && isFetching == false {
            isFetching = true
            delegate?.showLoader(show: isFetching)
            movieService.fetchMoviesList(page: pageCount) { [weak self] result in
                guard let self = self else { return }
                self.isFetching = false
                self.delegate?.showLoader(show: self.isFetching)

                switch result {
                case .success(let upcomingMovies):
                    guard let data = upcomingMovies else { return }
                    print(self.pageCount)
                    self.pageCount = data.page + 1
                    self.totalPages = data.totalPages
                    self.delegate?.onSuccess(data)
                case .failure(let error):
                    self.delegate?.onFailure(error)
                }
            }
        }
    }
}
