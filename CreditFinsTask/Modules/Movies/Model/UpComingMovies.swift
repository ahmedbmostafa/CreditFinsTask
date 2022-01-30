//
//  UpComingMovies.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Foundation

struct UpComingMovies : Decodable {

    let results : [Movie]?
    let page : Int
    let totalResults : Int
    let totalPages : Int

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
