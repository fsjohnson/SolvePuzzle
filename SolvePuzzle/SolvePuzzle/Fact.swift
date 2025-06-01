//
//  Programmer.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

class Fact {
    let id: String
    let text: String
    
    init?(dict: [String: Any]) {
        guard
            let id = dict["id"] as? String,
            let text = dict["text"] as? String
        else {
            print("Error parsing JSON to Fact")
            return nil
        }
        
        self.id = id
        self.text = text
    }
}
