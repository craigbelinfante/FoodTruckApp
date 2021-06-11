//
//  User.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 2/4/21.
//

import Foundation

struct UserRep: Codable {
    var username: String
    var password: String
}

struct Bearer: Codable {
    var token: String
    var id: Int
}
