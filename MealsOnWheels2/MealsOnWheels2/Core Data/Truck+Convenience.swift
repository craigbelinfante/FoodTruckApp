//
//  Truck+Convenience.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 1/25/21.
//

import Foundation
import CoreData

extension Truck {
    
    var truckRep: FavoriteTruck? {
        return FavoriteTruck(identifier: identifier?.uuidString ?? "",
                        favorite: favorite)
    }
    
    @discardableResult convenience init(identifier: UUID = UUID(),
                                        favorite: Bool,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext
    ) {
        self.init(context: context)
        self.identifier = identifier
        self.favorite = favorite
    }
    
    @discardableResult convenience init?(truckRep: FavoriteTruck, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let identifer = UUID(uuidString: truckRep.identifier), let favorite = truckRep.favorite else {return nil}
        
        self.init(identifier: identifer,
                  favorite: favorite,
                  context: context)
    }
    
}



