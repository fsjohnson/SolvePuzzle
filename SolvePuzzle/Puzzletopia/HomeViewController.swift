//
//  HomeViewController.swift
//  Puzzle Pals
//
//  Created by Felicity Johnson on 6/8/25.
//  Copyright © 2025 Runway. All rights reserved.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController, MFMailComposeViewControllerDelegate {

    let puzzles = [
        ("Steam Train", "steam_train_thumb"),
        ("Commuter Train", "commuter_train_thumb"),
        ("Freight Train", "freight_train_thumb")
    ]

    private var spinButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Choose a Train Puzzle"

        setupUI()
    }

    private func setupUI() {
        let hamburgerButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: nil,
            action: nil
        )
        
        hamburgerButton.menu = createMenu()
        hamburgerButton.primaryAction = nil // ensures menu shows on tap
        navigationItem.leftBarButtonItem = hamburgerButton
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold), NSAttributedString.Key.foregroundColor: UIColor.white],for: UIControl.State.normal)
        
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        // Create puzzle buttons with images
        for (index, puzzle) in puzzles.enumerated() {
            let button = createPuzzleButtonWithImage(title: puzzle.0, imageName: puzzle.1, tag: index)
            stack.addArrangedSubview(button)
        }

        // Spin to Play Button
        spinButton = UIButton(type: .system)
        spinButton.setTitle("🎉 Spin to Play! 🎉", for: .normal)
        spinButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        spinButton.backgroundColor = .systemOrange
        spinButton.setTitleColor(.white, for: .normal)
        spinButton.layer.cornerRadius = 12
        spinButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        spinButton.addTarget(self, action: #selector(spinToPlayTapped), for: .touchUpInside)
        spinButton.layer.shadowColor = UIColor.black.cgColor
        spinButton.layer.shadowOpacity = 0.3
        spinButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        spinButton.layer.shadowRadius = 5

        stack.addArrangedSubview(spinButton)

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showParentalGate() {
        let num1 = Int.random(in: 2...9)
        let num2 = Int.random(in: 2...9)
        let correctAnswer = num1 + num2
        let question = "What is \(num1) + \(num2)?"
        
        let alert = UIAlertController(title: "Ask your parents", message: question, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Your answer"
            textField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            guard let userInput = alert.textFields?.first?.text,
                  let answer = Int(userInput) else {
                self.showError("Please enter a number.")
                return
            }
            
            if answer == correctAnswer {
                self.sendSupportEmail()
            } else {
                self.showError("That’s not correct. Try again.")
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(submitAction)
        
        present(alert, animated: true)
    }

    func showError(_ message: String) {
        let errorAlert = UIAlertController(title: "Access Denied", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlert, animated: true)
    }
    
    func createMenu() -> UIMenu {
        let contactUs = UIAction(title: "Contact Us", image: UIImage(systemName: "envelope")) { _ in
            self.showParentalGate()
        }
        
        let privacyPolicy = UIAction(title: "Privacy Policy", image: UIImage(systemName: "doc.text")) { _ in
            let vc = PrivacyPolicyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return UIMenu(title: "", options: .displayInline, children: [contactUs, privacyPolicy])
    }
    
    func sendSupportEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(["support@runway.team"])
            mailVC.setSubject("Support request about Puzzle Pals")
            present(mailVC, animated: true)
        } else if let emailURL = URL(string: "mailto:support@hello.com") {
            UIApplication.shared.open(emailURL)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
    }

    private func createPuzzleButtonWithImage(title: String, imageName: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.addTarget(self, action: #selector(puzzleButtonTapped(_:)), for: .touchUpInside)
        
        // ImageView setup
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false   // <--- Important!
        
        // Label setup
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false       // <--- Important!
        
        // Horizontal stack for image + label
        let hStack = UIStackView(arrangedSubviews: [imageView, label])
        hStack.axis = .horizontal
        hStack.spacing = 16
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.isUserInteractionEnabled = false       // <--- Important!
        
        button.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
            hStack.topAnchor.constraint(equalTo: button.topAnchor),
            hStack.bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])
        
        return button
    }

    @objc private func puzzleButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        guard puzzles.indices.contains(index) else { return }
        let puzzle = puzzles[index]
        navigateToPuzzleDetail(named: puzzle.0, number: index + 1)
    }

    @objc private func spinToPlayTapped() {
        // Animate spin button rotation
        UIView.animate(withDuration: 0.5, animations: {
            self.spinButton.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.spinButton.transform = CGAffineTransform.identity
            }
        }

        // Pick random puzzle after animation delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let randomIndex = Int.random(in: 0..<self.puzzles.count)
            let randomPuzzle = self.puzzles[randomIndex]
            self.navigateToPuzzleDetail(named: randomPuzzle.0, number: randomIndex + 1)
        }
    }

    private func navigateToPuzzleDetail(named name: String, number: Int) {
        let viewModel = PuzzleViewModel(imageSlices: [], originalImageOrderArray: [], factArray: [], currentPuzzleNumber: number)
        let detailVC = PuzzleViewController(viewModel: viewModel)
        detailVC.puzzleName = name
        detailVC.puzzleViewModel.currentPuzzleNumber = number
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
