//
//  FavoriteManager.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import CoreData
import UIKit

protocol LocalDataManagerProtocol {
    func retrieveFavoriteMovies(completion:@escaping ([FavoriteMovies])->())
    func savePost(dataDic:[String:Any])
    func deleteAllData(entity: String)
    func deleteObjectFromCD (entity: String,withID: String)
}

class LocalDataManagerImp: LocalDataManagerProtocol{

    func retrieveFavoriteMovies(completion:@escaping ([FavoriteMovies])->()){
        let managedOC = CoreDataStore.managedObjectContext
        let request: NSFetchRequest<FavoriteMovies> = NSFetchRequest(entityName: "FavoriteMovies")
        do {
            let fetched = try managedOC!.fetch(request)
            completion(fetched)
        }catch let err {
            print(err)
        }
    }

    func savePost(dataDic:[String:Any])  {
        let managedOC = CoreDataStore.managedObjectContext
        if let newData = NSEntityDescription.entity(forEntityName: "FavoriteMovies",in: managedOC!) {
            let data = FavoriteMovies(entity: newData, insertInto: managedOC)
            data.id = dataDic["id"] as? String
            data.title = dataDic["title"] as? String
            data.imageUrl = dataDic["imageUrl"] as? String
            do {
                try managedOC!.save()
            }catch let err {
                print(err)
            }
        }
    }

    func deleteAllData(entity: String) {
        let managedOC = CoreDataStore.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let delQue = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try managedOC!.execute(delQue)
        }catch let err {
            print(err)
        }
    }

    func deleteObjectFromCD (entity: String,withID: String) {
        let managedOC = CoreDataStore.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = NSPredicate(format:"id = %@", withID)
        if let result = try? managedOC!.fetch(request) {
            for object in result {
                managedOC!.delete(object as! NSManagedObject)
            }
        }
        do {
            try managedOC!.save()
        } catch let err {
            print(err)
        }
    }
}
