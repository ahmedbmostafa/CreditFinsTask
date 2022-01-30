//
//  Base.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Alamofire

class BaseAPI<T: TargetType> {

    let sessionManager = EndPoint.fetchMovies.sessionManager

    func fetchMoviesList (target: T, page: Int, completion: @escaping(Result<UpComingMovies?, AFError>) -> Void) {
        let method = HTTPMethod(rawValue: target.method.rawValue)
        let path = target.path + "\(page)"
        sessionManager.request(target.base + path, method: method, encoding: JSONEncoding.default, headers: target.headers)
            .response { response in
                switch response.result {
                case.success:
                    guard let data = response.value else {return}
                    do {
                        let responseOBj = try JSONDecoder().decode(UpComingMovies.self, from: data!)
                        completion(.success(responseOBj))
                    }
                    catch let err{
                        debugPrint(err)
                    }
                case .failure(let err):
                    debugPrint(err)
                    completion(.failure(err))
                }
            }
    }
}
