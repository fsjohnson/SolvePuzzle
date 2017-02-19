//
//  DataStore.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

struct DataStore {
    static func getJson(with completion: @escaping ([[String: Any]]) -> Void) {
        guard let filePath = Bundle.main.path(forResource: "ios_model_challenge", ofType: "json") else { print("error unwrapping json playgrounds file path"); return }
        do {
            let data = try? NSData(contentsOfFile: filePath, options: .uncached)
            guard let castedData = data as? Data else { print("Error casting data as Data"); return }
            guard let rawDictionary = try JSONSerialization.jsonObject(with: castedData, options: []) as? [String : Any] else { print("Error serializing JSON"); return }
            guard let response = rawDictionary["response"] as? [String: Any] else { print("Error retrieving rawDictionary[response]"); return }
            guard let parsedJSON = response["locations"] as? [[String: Any]] else { print("Error retrieving response[locations]"); return }
            completion(parsedJSON)
        } catch {}
    }
}
