//
//  TruckRepresentation.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 1/25/21.
//

import Foundation
import MapKit

class TruckRep: NSObject, Codable, MKAnnotation {
    let latitude: Double
    let longitude: Double
    let imageOfTruck: String
    let name: String
    let favorite: Bool
    
    var coordinate: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
}

struct FavoriteTruck: Codable {
    var identifier: String
    var favorite: Bool?
}

