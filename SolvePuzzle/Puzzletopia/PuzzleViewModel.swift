//
//  PuzzleViewModel.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/19/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

class PuzzleViewModel {
    
    var imageSlices: [UIImage]!
    var originalImageOrderArray: [UIImage]!
    var factArray: [Fact]!
    var isSolved = false
    
    init(imageSlices: [UIImage], originalImageOrderArray: [UIImage], factArray: [Fact]) {
        self.imageSlices = imageSlices
        self.originalImageOrderArray = originalImageOrderArray
        self.factArray = factArray
    }
    
    convenience init() {
        self.init(imageSlices: [], originalImageOrderArray: [], factArray: [])
    }
    
    // MARK: - Populate & configure data
    private func populateImages() {
        for name in 1...12 {
            if let image = UIImage(named:String(name)){
                imageSlices.append(image)
                originalImageOrderArray.append(image)
            }
        }
    }
    
    private func randomize() {
        for num in 0..<12 {
            let randomIndex = Int(arc4random_uniform(UInt32(imageSlices.count)))
            if num != randomIndex {
                let temp = imageSlices[num]
                imageSlices[num] = imageSlices[randomIndex]
                imageSlices[randomIndex] = temp
            }
        }
    }
    
    private func checkCellCount() {
        if factArray.count < imageSlices.count {
            guard let newFact = Fact(dict: ["id": "", "text": ""]) else { return }
            factArray.append(newFact)
        }
    }
    
    private func getJson(with completion: @escaping ([[String: Any]]) -> Void) {
        guard let filePath = Bundle.main.path(forResource: "ios_model_challenge", ofType: "json") else { print("error unwrapping json playgrounds file path"); return }
        do {
            let data = try? NSData(contentsOfFile: filePath, options: .uncached)
            guard let castedData = data as? Data else { print("Error casting data as Data"); return }
            guard let rawDictionary = try JSONSerialization.jsonObject(with: castedData, options: []) as? [String : Any] else { print("Error serializing JSON"); return }
            guard let parsedJSON = rawDictionary["train_facts"] as? [[String: Any]] else { print("Error retrieving rawDictionary[train_facts]"); return }
            completion(parsedJSON)
        } catch {}
    }
    
    private func populateFactInfo() {
        getJson { (parsedJson) in
            for fact in parsedJson {
                guard let fact = Fact(dict: fact) else { print("Error unwrapping location in populateFactInfo"); return }
                self.factArray.append(fact)
            }
        }
    }
    
    // MARK: - Puzzle specific funcs
    func tryToSolvePuzzle() {
        imageSlices.removeAll()
        factArray.removeAll()
        populateImages()
        randomize()
        populateFactInfo()
        checkCellCount()
        isSolved = false
    }
    
    func skipPuzzle() {
        isSolved = true
        imageSlices.removeAll()
        factArray.removeAll()
        populateImages()
        populateFactInfo()
        checkCellCount()
    }
    
    func moveCell(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = imageSlices.remove(at: sourceIndexPath.item)
        imageSlices.insert(itemToMove, at: destinationIndexPath.item)
    }
    
    func playAgain() {
        imageSlices.removeAll()
        originalImageOrderArray.removeAll()
        factArray.removeAll()
        isSolved = false
    }
}
