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
    var favoriteColor: String
    var age: Int
    var weight: Double
    var phone: String
    var isArtist: Bool
    var location: Location?
    var platform: String?
    
    init?(dict: [String: Any]) {
        guard
            let name = dict["name"] as? String,
            let favoriteColor = dict["favorite_color"] as? String,
            let age = dict["age"] as? Int,
            let weight = dict["weight"] as? Double,
            let phone = dict["phone"] as? String,
            let isArtist = dict["is_artist"] as? Bool
            else { print("Error parsing JSON to Programmer"); return nil }
            
        self.name = name
        self.favoriteColor = favoriteColor
        self.age = age
        self.weight = weight
        self.phone = phone
        self.isArtist = isArtist
    }
    
    init(name: String, favorite_color: String, age: Int, weight: Double, phone: String, is_artist: Bool) {
        self.name = name
        self.favoriteColor = favorite_color
        self.age = age
        self.weight = weight
        self.phone = phone
        self.isArtist = is_artist
    }
    
    convenience init() {
        self.init(name: "", favorite_color: "", age: 0, weight: 0.0, phone: "", is_artist: false)
    }
}
