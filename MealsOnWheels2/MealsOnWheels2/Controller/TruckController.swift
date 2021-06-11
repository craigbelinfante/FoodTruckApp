//
//  TruckController.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 1/26/21.
//

import Foundation
import CoreData

class TruckController {
    var trucks: [TruckRep] = Bundle.main.decode("truck.json")
    
    var userFavoritedTrucks = [FavoriteTruck]()
    
    // CRUD
    // create read update delete
    // save and load
    
    func fetchFavoritedTrucks() {
        let context = CoreDataStack.shared.container.newBackgroundContext()
        
        let fetchRequest: NSFetchRequest<Truck> = Truck.fetchRequest()
       // fetchRequest.predicate = NSPredicate(format: "identifier in %@", identifiersToFetch)
    }
    
}

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError()
        }
        return loaded
    }
}
