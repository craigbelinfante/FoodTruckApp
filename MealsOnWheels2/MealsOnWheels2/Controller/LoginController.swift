//
//  LoginController.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 2/4/21.
//

import Foundation
import UIKit

final class LoginController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noData
        case noDecode
        case noToken
        case tryAgain
        case otherError
    }
    
    var bearer: Bearer?
}
