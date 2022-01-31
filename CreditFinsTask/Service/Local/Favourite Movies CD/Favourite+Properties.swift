//
//  Favourite+Properties.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Foundation
import CoreData


extension FavouriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovies> {
        return NSFetchRequest<FavouriteMovies>(entityName: "FavouriteMovies")
    }
    @NSManaged public var id: String?
}
extension FavouriteMovies : Identifiable {
}
