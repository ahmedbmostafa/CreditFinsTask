//
//  Target.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum Task {
    case requestPlain // without parameters
    case requestParameters(parameters: Parameters)
}

protocol TargetType {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: HTTPHeaders { get }
    var sessionManager: Session { get }
}
