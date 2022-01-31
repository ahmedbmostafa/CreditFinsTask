//
//  MockMovieDetailVC.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MockMovieDetailVC: DetailsVC {

    var isMovieImageView = false
    var isShowMovieTitle = false
    var isShowMovieReleaseDate = false
    var isShowMovieDescription = false
    var isShowMovieVoteAverage = false
    var isShowMoviePopulaity = false

    override func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else { return }

            switch output {
            case .showMovieBannerImageView( _):
                self.isMovieImageView = true
            case .showMovieTitle(_):
                self.isShowMovieTitle = true
            case .showMovieReleaseDate( _):
                self.isShowMovieReleaseDate = true
            case .showMovieDescription( _):
                self.isShowMovieDescription = true
            case .showMovieVoteAvg( _):
                self.isShowMovieVoteAverage = true
            case .showMoviePopularity( _):
                self.isShowMoviePopulaity = true
            }
        }
    }
}
