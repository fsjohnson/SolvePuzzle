//
//  BackView.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 2/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class BackView: UIView {
    
    var posseImageView: UIImageView!
    var stackView: UIStackView!
    
    weak var programmer: Programmer? {
        didSet {
            commonInit()
            populateLabels()
            configBorder()
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightHeavy)
        return label
    }()
    
    lazy var favoriteColorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        return label
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        return label
    }()
    
    lazy var isArtistLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        return label
    }()
    
    lazy var platformLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        return label
    }()
    
    // MARK: - Config view layout
    private func commonInit() {
        posseImageView = UIImageView()
        posseImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(posseImageView)
        posseImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        posseImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        posseImageView.image = UIImage(named: "PosseLogo")
        
        stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.fillProportionally
        stackView.alignment = UIStackViewAlignment.center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        let labels = [nameLabel, favoriteColorLabel, ageLabel, weightLabel, phoneLabel, isArtistLabel, locationLabel, platformLabel]
        for label in labels {
            stackView.addArrangedSubview(label)
            configConstraints(of: label)
        }
    }
    
    private func configConstraints(of label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        label.textAlignment = .center
    }
    
    private func configBorder() {
        guard let location = programmer?.location?.locality else { print("Error unwrapping programmer location"); return }
        switch location {
        case "New York":
            posseImageView.removeFromSuperview()
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.themeYellow.cgColor
            self.backgroundColor = UIColor.themeYellow.withAlphaComponent(0.1)
        case "Chicago":
            posseImageView.removeFromSuperview()
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.themeGreen.cgColor
            self.backgroundColor = UIColor.themeGreen.withAlphaComponent(0.1)
        case "Oakland":
            posseImageView.removeFromSuperview()
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.themeDarkBlue.cgColor
            self.backgroundColor = UIColor.themeDarkBlue.withAlphaComponent(0.1)
        default:
            break
        }
    }
    
    // MARK: - Populate & config labels
    private func populateLabels() {
        guard let name = programmer?.name else { print("Error unwrapping programmer name in cell"); return}
        guard let favoriteColor = programmer?.favoriteColor else { print("Error unwrapping programmer fav color in cell"); return }
        guard let age = programmer?.age else { print("Error unwrapping programmer age in cell"); return }
        guard let weight = programmer?.weight else { print("Error unwrapping programmer weight in cell"); return }
        guard let phone = programmer?.phone else { print("Error unwrapping programmer phone in cell"); return }
        guard let isArtist = programmer?.isArtist else { print("Error unwrapping programmer isArtist in cell"); return }
        guard let location = programmer?.location?.locality else { print("Error unwrapping programmer location in cell"); return }
        guard let platform = programmer?.platform else { print("Error unwrapping programmer platform in cell"); return }
        
        nameLabel.text = name
        favoriteColorLabel.text = "Fav color: \(favoriteColor.capitalized)"
        ageLabel.text = "Age:\(age)"
        weightLabel.text = "Weight: \(weight) lbs"
        phoneLabel.text = "Phone: \(formatPhoneNumber(phone: phone))"
        isArtistLabel.text = "Is an artist: \(formatIsArtist(isArtist: isArtist))"
        locationLabel.text = "Location: \(location)"
        platformLabel.text = "Platform: \(platform)"
    }
    
    private func formatPhoneNumber(phone: String) -> String {
        var formattedPhone = String()
        var phoneArray = Array(phone.characters)
        phoneArray.insert("(", at: 0)
        phoneArray.insert(")", at: 4)
        phoneArray.insert(" ", at: 5)
        phoneArray.insert("-", at: 9)
        for item in phoneArray {
            formattedPhone.append(item)
        }
        return formattedPhone
    }
    
    private func formatIsArtist(isArtist: Bool) -> String {
        if isArtist == false {
            return "No"
        } else {
            return "Yes"
        }
    }
}
