//
//  MoviesViewModel.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Foundation
import Alamofire

typealias MoviesViewModelOutput = (MoviesViewModel.Output) -> ()

protocol MoviesViewModelProtocol {
    var dataProvider: MovieDataProviderProtocol! { get }
    var numberOfMovies: Int { get }
    var output: MoviesViewModelOutput? { get set }
    func getMovieListCellViewModel(index : Int) -> MovieTableViewCellViewModel
    func didSelectMovie(index : Int)
    func didLoad()
    func tableViewDidReachToEnd()
    func didSelectFavorite(completion:@escaping(Bool)->())
    func clearFilter()
}

class MoviesViewModel: MoviesViewModelProtocol{

    enum Output {
        case reloadMovies
        case showActivityIndicator(show: Bool)
        case showError(error: Error)
    }

    var dataProvider: MovieDataProviderProtocol!
    var coordinator: MoviesCoordinator!
    var localDataManager: LocalDataManagerProtocol

    init(withDataProvider movieListDataProvider: MovieDataProviderProtocol,andCoordinator movieCoordinator: MoviesCoordinator, localDataManager:LocalDataManagerProtocol) {
        self.dataProvider = movieListDataProvider
        self.coordinator = movieCoordinator
        self.localDataManager = localDataManager
    }

    var output: MoviesViewModelOutput?

    var isFilteringActive: Bool = false

    private var allMovieListViewModels = [MovieTableViewCellViewModel]() {
        didSet {
            output?(.reloadMovies)
        }
    }

    private var filteredMovieListViewModels = [MovieTableViewCellViewModel]()  {
        didSet {
            output?(.reloadMovies)
        }
    }

    private var movieDataSourceViewModels: [MovieTableViewCellViewModel] {
        if isFilteringActive {
            return filteredMovieListViewModels
        }
        return allMovieListViewModels
    }

    var numberOfMovies: Int {
        return movieDataSourceViewModels.count
    }

    func didLoad() {
        getUpcomingMovies()
    }

    func tableViewDidReachToEnd() {
        getUpcomingMovies()
    }

    func didSelectFavorite(completion:@escaping(Bool)->()) {
        activateFilter { isEmpty in
            completion(isEmpty)
        }
    }

    func getMovieListCellViewModel(index : Int) -> MovieTableViewCellViewModel {
        return movieDataSourceViewModels[index]
    }

    func getUpcomingMovies() {
        if isFilteringActive == false  { dataProvider.fetchUpcomingMovies() }
    }

    private func activateFilter(completion:@escaping(Bool)->()) {
        isFilteringActive = true
        localDataManager.retrieveFavoriteMovies { dataList in
            if dataList.count > 0 {
                for data in dataList {
                    let id = data.id ?? ""
                    print(id)
                    let filtered = self.allMovieListViewModels.filter({ String(($0.movie?.id ?? 0)) == id})
                    for data in filtered {
                        self.filteredMovieListViewModels.append(data)
                    }
                }
                completion(false)
            } else {
                completion(true)
            }
        }
        
    }
    func clearFilter() {
        isFilteringActive = false
        filteredMovieListViewModels.removeAll()
    }
    func didSelectMovie(index: Int) {
        coordinator.navigateToMovieDetail(withMovie: getMovieListCellViewModel(index: index).movie)
        print(index)
    }
}
extension MoviesViewModel: MovieDataProviderDelegate {

    func showLoader(show: Bool) {
        output?(.showActivityIndicator(show: show))
    }

    func onSuccess(_ upcomingMovies: UpComingMovies) {
        guard let results = upcomingMovies.results else { return }
        allMovieListViewModels.append(contentsOf: results.map { MovieTableViewCellViewModel.init($0) })
    }

    func onFailure(_ error: AFError) {
         output?(.showError(error: error))
    }
}
