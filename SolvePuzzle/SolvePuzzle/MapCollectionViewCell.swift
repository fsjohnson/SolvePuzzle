//
//  MapCollectionViewCell.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {
    
    var cardViews: (frontView: UIView, backView: UIView)?
    var frontView = FrontView()
    var backView = BackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        configFrontView()
    }
    
    private func configFrontView() {
        self.contentView.addSubview(frontView)
        frontView.translatesAutoresizingMaskIntoConstraints = false
        frontView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        frontView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        frontView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        frontView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    private func configBackView() {
        self.contentView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    func flipCardAnimation() {
        if backView.superview != nil {
            configFrontView()
            cardViews = (frontView: frontView, backView: backView)
        } else {
            configBackView()
            cardViews = (frontView: backView, backView: frontView)
        }
        let transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
            self.cardViews?.backView.removeFromSuperview()
            self.contentView.addSubview((self.cardViews?.frontView)!)
        }, completion: nil)
    }
}
