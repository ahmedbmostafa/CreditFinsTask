//
//  MovieTableCellViewModel.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Foundation

struct MovieTableViewCellViewModel {

    var movieTitle: String
    var movieDescription: String
    var movieImgUrl: String
    var movie: Movie?
    var localDataManagerImp: LocalDataManagerProtocol! = LocalDataManagerImp()

    init(_ movie: Movie?) {
        self.movie = movie
        self.movieTitle = movie?.title ?? ""
        self.movieDescription = movie?.overview ?? ""
        self.movieImgUrl = APIConstants.ImageBaseURL + APIConstants.ImagePreviewSize + (movie?.posterPath ?? "")
    }

    func saveMovie(movieId: String){
        fetchFavoriteMovies(movieId: movieId) {
            saveToCoreData()
        }
    }

    func deleteMovie(movieId: String, completion: @escaping()->()){
        localDataManagerImp.deleteObjectFromCD(entity: "FavoriteMovies", withID: movieId)
        completion()
    }
    
    func saveToCoreData(){
        let id = String(movie?.id ?? 0)
        let title = movie?.title ?? ""
        let imageUrl = APIConstants.ImageBaseURL + APIConstants.ImagePreviewSize + (movie?.posterPath ?? "")
        let dict = ["id": id, "title": title, "imageUrl": imageUrl] as [String : Any]
        localDataManagerImp.savePost(dataDic: dict)
    }

    func fetchFavoriteMovies(movieId: String, completion: @escaping()->()) {
        localDataManagerImp.retrieveFavoriteMovies { dataList in
            if dataList.count > 0 {
                dataList.forEach { data in
                    let id = data.id ?? ""
                    if id != movieId {
                        localDataManagerImp.deleteObjectFromCD(entity: "FavoriteMovies", withID: movieId)
                        completion()
                    }
                }
            }else {
                completion()
            }
        }
    }
}
