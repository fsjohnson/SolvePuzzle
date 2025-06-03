//
//  PrivacyPolicyViewController.swift
//  SolvePuzzle
//
//  Created by Felicity Johnson on 6/2/25.
//  Copyright © 2025 FJ. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Privacy Policy"
        view.backgroundColor = .systemBackground
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.text = """
        Privacy Policy

        Effective Date: June 1, 2025

        Puzzle Pals does not collect, store, or share any personal data.

        1. Information Collection
        We do not collect any personal information from users of the app. This includes but is not limited to names, email addresses, phone numbers, device identifiers, location data, or usage analytics.

        2. Data Storage
        Since we do not collect any data, there is no data stored either locally on the device or remotely on our servers.

        3. Third-Party Services
        This app does not use third-party services (such as analytics providers, advertising networks, or cloud services) that collect user data.

        4. Contact
        If you have any questions about this Privacy Policy, you may contact us at:

        Email: support@runway.team

        5. Changes to This Policy
        We may update this Privacy Policy if necessary. Any changes will be posted in-app and take effect immediately upon posting.
        """
        
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
