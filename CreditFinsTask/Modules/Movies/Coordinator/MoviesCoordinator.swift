//
//  MoviesCoordinator.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 29/01/2022.
//

import Foundation
import UIKit

protocol MoviesCoordinator {
    func navigateToMovieDetail(withMovie movie: Movie?)
}

class MoviesCoordinatorImpl: MoviesCoordinator {
    weak var view: UIViewController?
    var appFlowManager: AppFlowManager?
    init(view: UIViewController?) {
        self.view = view
    }
}

extension MoviesCoordinatorImpl {
    func navigateToMovieDetail(withMovie movie: Movie?) {
        appFlowManager = AppFlowManager()
        let vc = appFlowManager?.coordinateToDetailsVC(movie: movie)
        view?.navigationController?.pushViewController(vc!, animated: true)
    }
}
