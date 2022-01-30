//
//  DetailsViewModel.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 29/01/2022.
//

import Foundation

typealias DetailsModelOutput = (DetailsViewModel.Output) -> ()

protocol DetailsViewModelProtocol {

    var output: DetailsModelOutput? { get set }
    func didLoad()
}

final class DetailsViewModel: DetailsViewModelProtocol {

    enum Output {
        case showMovieBannerImageView(url: URL)
        case showMovieTitle(title: String)
        case showMovieDescription(description: String)
        case showMovieReleaseDate(releaseDate: String)
        case showMovieVoteAvg(voteAvg: String)
        case showMoviePopularity(popularity: String)
    }

    var output: DetailsModelOutput?
    private var movie: Movie?

    var bannerImageUrl: URL? {
        return URL(string: APIConstants.ImageBaseURL + APIConstants.ImageFullSize + (movie?.posterPath ?? ""))
    }

    func didLoad() {
        output?(.showMovieTitle(title: movie?.title ?? ""))
        output?(.showMovieDescription(description: movie?.overview ?? ""))
        output?(.showMovieReleaseDate(releaseDate: movie?.releaseDate ?? ""))
        output?(.showMovieVoteAvg(voteAvg: String(movie?.voteAverage ?? 0)))
        output?(.showMoviePopularity(popularity: String(movie?.popularity ?? 0)))
        showBannerImage()
    }

    init(_ movie: Movie?) {
        self.movie = movie
    }

    private func showBannerImage() {
        guard let bannerImageUrl = bannerImageUrl else { return }
        output?(.showMovieBannerImageView(url: bannerImageUrl))
    }
    
    private func showReleaseDate() {
        let date = movie?.releaseDate ?? ""
        output?(.showMovieReleaseDate(releaseDate: date))
    }
}
