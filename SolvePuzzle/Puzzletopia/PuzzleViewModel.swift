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
    
    var currentPuzzleNumber: Int
    var imageSlices: [UIImage] = []
    var originalImageOrderArray: [UIImage] = []
    var factArray: [Fact] = []
    var isSolved = false
    
    init(imageSlices: [UIImage], originalImageOrderArray: [UIImage], factArray: [Fact], currentPuzzleNumber: Int) {
        self.currentPuzzleNumber = currentPuzzleNumber
        self.imageSlices = imageSlices
        self.originalImageOrderArray = originalImageOrderArray
        self.factArray = factArray
    }
    
    // MARK: - Populate & configure data
    private func populateImages(puzzleNumber: Int) {
        imageSlices.removeAll()
            originalImageOrderArray.removeAll()
            
            for pieceIndex in 1...12 {
                let imageName = "puzzle\(puzzleNumber)_\(pieceIndex)"
                if let image = UIImage(named: imageName) {
                    imageSlices.append(image)
                    originalImageOrderArray.append(image)
                } else {
                    print("Missing image: \(imageName)")
                }
            }
    }
    
    private func randomize() {
        imageSlices.shuffle()
    }
    
    private func checkCellCount() {
        if factArray.count < imageSlices.count {
            guard let newFact = Fact(dict: ["id": "", "text": ""]) else { return }
            factArray.append(newFact)
        }
    }
    
    private func getFacts(for puzzleKey: String, completion: @escaping ([[String: Any]]) -> Void) {
        guard let filePath = Bundle.main.path(forResource: "ios_model_challenge", ofType: "json") else {
            print("error unwrapping json playgrounds file path")
            return
        }
        
        do {
            let data = try NSData(contentsOfFile: filePath, options: .uncached)
            guard let castedData = data as? Data else {
                print("Error casting data as Data")
                return
            }
            
            guard let rawDictionary = try JSONSerialization.jsonObject(with: castedData, options: []) as? [String : Any] else {
                print("Error serializing JSON")
                return
            }
            
            guard let puzzlesDict = rawDictionary["puzzles"] as? [String: Any] else {
                print("Error retrieving rawDictionary[puzzles]")
                return
            }
            
            guard let puzzleData = puzzlesDict[puzzleKey] as? [String: Any] else {
                print("Error retrieving puzzle data for key: \(puzzleKey)")
                return
            }
            
            guard let factsArray = puzzleData["facts"] as? [[String: Any]] else {
                print("Error retrieving facts array for puzzle: \(puzzleKey)")
                return
            }
            
            completion(factsArray)
            
        } catch {
            print("Error reading JSON: \(error.localizedDescription)")
        }
    }

    
    private func populateFactInfo() {
        getFacts(for: "puzzle\(currentPuzzleNumber)") { (parsedJson) in
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
        populateImages(puzzleNumber: currentPuzzleNumber)
        randomize()
        populateFactInfo()
        checkCellCount()
        isSolved = false
    }
    
    func skipPuzzle() {
        isSolved = true
        imageSlices.removeAll()
        factArray.removeAll()
        populateImages(puzzleNumber: currentPuzzleNumber)
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
