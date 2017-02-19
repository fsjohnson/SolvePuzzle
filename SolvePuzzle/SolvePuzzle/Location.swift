//
//  Location.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

struct Location {
    var public_id: String
    var locality: String
    var region: String
    var postal_code: String
    var country: String
    var services: [[String: Any]]
    
    init(dict: [String: Any]) {
        self.public_id = dict["public_id"] as! String
        self.locality = dict["locality"] as! String
        self.region = dict["region"] as! String
        self.services = dict["services"] as! [[String: Any]]
        self.postal_code = dict["postal_code"] as! String
        self.country = dict["country"] as! String
    }
    
    init(public_id: String, locality: String, region: String, postal_code: String, country: String, services: [[String: Any]]) {
        self.public_id = public_id
        self.locality = locality
        self.region = region
        self.postal_code = postal_code
        self.country = country
        self.services = services
    }
}
