//
//  BaseAlertViewController.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class BaseAlertViewController: CoreView {

    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var onDoneButtonSelected: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init() {
        super.init()
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        if let done = self.onDoneButtonSelected {
            done()
        }
        self.removeFromSuperview()
    }
    
    func setup(labels: [UILabel]) {
        stackView.challenge_clearArrangedSubviews()
        
        for label in labels {
            stackView.addArrangedSubview(label)
        }
    }
}

extension UIStackView {
    func challenge_clearArrangedSubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
