//
//  Programmer.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

class Programmer {
    var name: String
    var favorite_color: String
    var age: Int
    var weight: Double
    var phone: String
    var is_artist: Bool
    var location: Location?
    var platform: String?
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
        self.favorite_color = dict["favorite_color"] as! String
        self.age = dict["age"] as! Int
        self.weight = dict["weight"] as! Double
        self.phone = dict["phone"] as! String
        self.is_artist = dict["is_artist"] as! Bool
    }
    
    init(name: String, favorite_color: String, age: Int, weight: Double, phone: String, is_artist: Bool) {
        self.name = name
        self.favorite_color = favorite_color
        self.age = age
        self.weight = weight
        self.phone = phone
        self.is_artist = is_artist
    }
    
    convenience init() {
        self.init(name: "", favorite_color: "", age: 0, weight: 0.0, phone: "", is_artist: false)
    }
}
