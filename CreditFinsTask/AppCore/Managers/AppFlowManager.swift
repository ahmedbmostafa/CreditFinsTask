//
//  AppFlowManager.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import UIKit


class AppFlowManager {

    func start(navigationController: UINavigationController) {
        let vc = creatMovieVC()
        navigationController.pushViewController(vc, animated: false)
    }
}

extension AppFlowManager {
    
    func creatMovieVC() -> UIViewController {
        let movieVC = MovieVC.instantiate(fromAppStoryboard: .Main)
        let dataProvider = MovieDataProviderImpl()
        let localDataManager = LocalDataManagerImp()
        dataProvider.movieService = MoviesServiceImp()
        let coordinator = MoviesCoordinatorImpl(view: movieVC)
        let viewModel = MoviesViewModel(withDataProvider: dataProvider, andCoordinator: coordinator, localDataManager: localDataManager)
        dataProvider.delegate = viewModel
        viewModel.dataProvider = dataProvider
        movieVC.viewModel = viewModel
        return movieVC
    }

    func coordinateToDetailsVC(movie: Movie?) -> UIViewController {
        let detailsVC = DetailsVC.instantiate(fromAppStoryboard: .Main)
        let viewModel = DetailsViewModel(movie)
        detailsVC.viewModel = viewModel
        return detailsVC
    }
}
