//
//  LaunchView.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class LaunchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configLaunch()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var launchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Map")
        return imageView
    }()
    
    func configLaunch() {
        self.addSubview(launchImage)
        launchImage.translatesAutoresizingMaskIntoConstraints = false
        launchImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        launchImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        launchImage.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
        launchImage.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
    }
}
