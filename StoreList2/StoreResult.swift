//
//  StoreResult.swift
//  StoreList2
//
//  Created by Andjela Rakic on 10/12/21.
//

import Foundation
import UIKit


struct StoreResult: Codable {
    
    let stores: [Store]
}

struct Store: Codable {
    let address: String
    let name: String
    let city: String
    let phone: String
    let longitude: String
    let latitude: String
    let storeLogoURL: String
    let state: String
    let zipcode: String
    
}
