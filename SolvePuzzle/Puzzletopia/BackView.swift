//
//  BackView.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class BackView: UIView {
    
    var stackView: UIStackView!
    
    weak var fact: Fact? {
        didSet {
            commonInit()
            if fact?.text != "" {
                populateLabels()
            }
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.heavy)
        return label
    }()
    
    // MARK: - Config view layout
    private func commonInit() {
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        stackView.layer.borderWidth = 3.0
        stackView.layer.borderColor = UIColor.themeYellow.cgColor
        stackView.backgroundColor = UIColor.themeYellow.withAlphaComponent(0.1)
        
        let labels = [nameLabel]
        for label in labels {
            stackView.addArrangedSubview(label)
            configConstraints(of: label)
        }
    }
    
    private func configConstraints(of label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8).isActive = true
        label.textAlignment = .center
    }
    
    // MARK: - Populate & config labels
    private func populateLabels() {
        guard let text = fact?.text else { print("Error unwrapping text in cell"); return}
        
        nameLabel.text = text
    }
}
