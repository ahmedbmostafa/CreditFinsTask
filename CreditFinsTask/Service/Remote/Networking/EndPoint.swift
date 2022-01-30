//
//  EndPoint.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Alamofire

enum EndPoint {
    case fetchMovies
}

extension EndPoint: TargetType {

    var base: String {
        switch self {
        default:
            return APIConstants.BaseURL
        }
    }
    var path: String {
        switch self {
        case .fetchMovies:
            return "upcoming?api_key=\(APIConstants.ApiKey)&page="
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchMovies:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .fetchMovies:
            return .requestPlain
        }
    }

    var headers: HTTPHeaders {
        switch self {
        default:
            let header: HTTPHeaders = ["Content-Type": "application/json;charset=utf-8"]
            return header
        }
    }
    var sessionManager: Session  {
        switch self {
        default:
            let configuration = URLSessionConfiguration.af.default
            configuration.requestCachePolicy = .returnCacheDataElseLoad
            let responseCacher = ResponseCacher(behavior: .modify { _, response in
                return CachedURLResponse(
                    response: response.response,
                    data: response.data,
                    storagePolicy: .allowed)
            })
            return Session(
                configuration: configuration,
                cachedResponseHandler: responseCacher)
        }
//        get {
//            let configuration = URLSessionConfiguration.af.default
//            configuration.requestCachePolicy = .returnCacheDataElseLoad
//            let responseCacher = ResponseCacher(behavior: .modify { _, response in
//                return CachedURLResponse(
//                    response: response.response,
//                    data: response.data,
//                    storagePolicy: .allowed)
//            })
//            return Session(
//                configuration: configuration,
//                cachedResponseHandler: responseCacher)
//        }
    }
}
