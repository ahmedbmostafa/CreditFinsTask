//
//  Favorite+Properties.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import Foundation
import CoreData


extension FavoriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovies> {
        return NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
    }
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?
}
extension FavoriteMovies : Identifiable {
}
