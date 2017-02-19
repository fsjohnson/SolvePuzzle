//
//  Location.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

struct Location {
    var publicId: String
    var locality: String
    var region: String
    var postalCode: String
    var country: String
    var services: [[String: Any]]
    
    init?(dict: [String: Any]) {
        guard
            let publicId = dict["public_id"] as? String,
            let locality = dict["locality"] as? String,
            let region = dict["region"] as? String,
            let services = dict["services"] as? [[String: Any]],
            let postalCode = dict["postal_code"] as? String,
            let country = dict["country"] as? String
            else { print("Error parsing JSON to Location"); return nil }

        self.publicId = publicId
        self.locality = locality
        self.region = region
        self.services = services
        self.postalCode = postalCode
        self.country = country
    }
    
    init(publicId: String, locality: String, region: String, postalCode: String, country: String, services: [[String: Any]]) {
        self.publicId = publicId
        self.locality = locality
        self.region = region
        self.postalCode = postalCode
        self.country = country
        self.services = services
    }
}
