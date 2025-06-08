//
//  PuzzleViewController.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var puzzleName: String?
    var imageCollectionView: UICollectionView!
    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var numberOfRows: CGFloat!
    var numberOfColumns: CGFloat!
    let puzzleViewModel: PuzzleViewModel
    
    init(viewModel: PuzzleViewModel) {
        self.puzzleViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout()
        configCollectionView()
        configCellLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentAlertWithTitle(title: "Let's Play!", message: "Solve the puzzle by holding down on a cell and dragging it to its correct position. Solving the puzzle unlocks train facts. Don't want to play? Click \"Skip\" below.")
    }
    
    func presentAlertWithTitle(title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {(action: UIAlertAction) in
            self.puzzleViewModel.tryToSolvePuzzle()
            self.imageCollectionView.reloadData()
        }
        let skipAction = UIAlertAction(title: "Skip", style: .default) {(action: UIAlertAction) in
            self.puzzleViewModel.skipPuzzle()
            self.imageCollectionView.reloadData()
            self.presentSuccessAlertWithTitle(title: "Next Step", message: "Click the cells below to learn train facts.")
        }
        alertController.addAction(OKAction)
        alertController.addAction(skipAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configLayout() {
        self.view.backgroundColor = UIColor.white
        self.title = puzzleName ?? "Puzzle"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Over", style: .done, target: self, action: #selector(playAgainButton))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold), NSAttributedString.Key.foregroundColor: UIColor.white],for: UIControl.State.normal)
    }
    
    @objc func playAgainButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func menuButton() {
        self.presentAlertWithTitle(title: "Let's Play!", message: "Solve the puzzle by holding down on a cell and dragging it to its correct position. Solving the puzzle unlocks train facts. Don't want to play? Click \"Skip\" below.")
    }
    
    func configCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        imageCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.isUserInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.imageCollectionView.addGestureRecognizer(longPressGesture)
        
        imageCollectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        imageCollectionView.showsVerticalScrollIndicator = false
        imageCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(imageCollectionView)
        self.imageCollectionView.allowsSelection = true
    }
    
    func configCellLayout() {
        guard let navHeight = navigationController?.navigationBar.frame.height else { print("Error calc nav height on collectionView"); return }
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height - navHeight
        numberOfRows = 3.0
        numberOfColumns = 4.0
        spacing = 2
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        let totalWidthDeduction = (spacing + spacing + spacing + sectionInsets.right + sectionInsets.left)
        let totalHeightDeduction = (spacing + spacing + sectionInsets.bottom + sectionInsets.top)
        itemSize = CGSize(width: (screenWidth - totalWidthDeduction) / numberOfColumns, height: (screenHeight - totalHeightDeduction) / numberOfRows)
    }
    
    // MARK: - Handle changing order of images
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state){
        case UIGestureRecognizer.State.began:
            guard let selectedIndexPath = self.imageCollectionView.indexPathForItem(at: gesture.location(in: self.imageCollectionView)) else { return }
            imageCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizer.State.changed:
            imageCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizer.State.ended:
            imageCollectionView.endInteractiveMovement()
        default:
            imageCollectionView.cancelInteractiveMovement()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.imageCollectionView.performBatchUpdates({
            self.puzzleViewModel.moveCell(from: sourceIndexPath, to: destinationIndexPath)
        }, completion: { completed in
            if self.puzzleViewModel.originalImageOrderArray == self.puzzleViewModel.imageSlices {
                self.puzzleViewModel.isSolved = true
                self.presentSuccessAlertWithTitle(title: "Great Job!", message: "Click the cells below to learn train facts.")
            }
        })
    }
    
    func presentSuccessAlertWithTitle(title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Handle flip animation
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if puzzleViewModel.isSolved == true {
            let cell = collectionView.cellForItem(at: indexPath) as! MapCollectionViewCell
            cell.flipCardAnimation()
        }
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension PuzzleViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puzzleViewModel.imageSlices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MapCollectionViewCell
        cell.frontView.imageView.image = puzzleViewModel.imageSlices[indexPath.row]
        cell.backView.fact = puzzleViewModel.factArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
}
