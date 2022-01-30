//
//  DetailsVC.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 29/01/2022.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var desciptionLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var voteAvgLbl: UILabel!
    @IBOutlet weak var populaityLbl: UILabel!

    var viewModel: DetailsViewModelProtocol!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.5647058824, blue: 0.6901960784, alpha: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelOutput()
        viewModel.didLoad()
    }

    func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else { return }

            switch output {
            case .showMovieBannerImageView(let url):
                self.movieImg.kf.setImage(with: url)
            case .showMovieTitle(let title):
                self.titleLbl.text = title
                self.title = title
            case .showMovieReleaseDate(let releaseDate):
                self.releaseDateLbl.text = releaseDate
            case .showMovieDescription(let description):
                self.desciptionLbl.text = description
            case .showMovieVoteAvg(voteAvg: let voteAvg):
                self.voteAvgLbl.text = voteAvg
            case .showMoviePopularity(popularity: let popularity):
                self.populaityLbl.text = popularity
            }
        }
    }
}
