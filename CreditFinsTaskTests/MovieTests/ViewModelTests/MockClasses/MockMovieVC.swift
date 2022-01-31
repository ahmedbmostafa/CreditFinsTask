//
//  MockMovieVC.swift
//  CreditFinsTaskTests
//
//  Created by ahmed mostafa on 31/01/2022.
//

import XCTest
@testable import CreditFinsTask

class MockMovieVC: MovieVC {

    var isShowLoaderCalls = false
    var isReloadMoviesCalls = false
    var isShowErrorCalls = false
    
    override func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else { return }
            switch output {
            case .reloadMovies:
                self.isReloadMoviesCalls = true
            case .showActivityIndicator( _):
                self.isShowLoaderCalls = true
            case .showError( _):
                self.isShowErrorCalls = true
            }
        }
    }

}
