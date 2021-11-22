//
//  LoginViewController.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Foundation
import Lottie

class LoaderLottie: CoreView {
    
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var contentAnimationView: UIView!
    private var animationView = AnimationView()
    
    private var alphaColor: CGFloat = 0.9
    
    required init() {
        super.init()
        setupAccessibility()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAccessibility()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAccessibility()
    }
    
    private func setupAccessibility() {
        self.accessibilityIdentifier = "loaderScreen"
        self.accessibilityActivate()
    }
    
    
    private func getAnimation(_ style: LoaderStyle) -> Animation? {
        switch style {
        case .normal:
             return Animation.named("normalLoading")
        }
    }
    
    private func getAlpha(_ style: LoaderStyle) -> CGFloat {
        return alphaColor
    }
    
    func showAnimation(_ style: LoaderStyle) {
        self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        if let first = self.contentAnimationView.subviews.first(where: { $0 === self.animationView.self }) as? AnimationView {
            first.animation = self.getAnimation(style)
            first.loopMode = .loop
            first.play()
            return
        }
        
        self.contentAnimationView.addSubview(self.animationView)
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        self.animationView.equalBoundsTo(view: self.contentAnimationView)
        self.animationView.animation = self.getAnimation(style)
        self.animationView.loopMode = .loop
        self.animationView.play()
    }
    
    func hideAnimation() {
        self.backgroundView.backgroundColor = UIColor.clear
        self.animationView.stop()
        self.animationView.animation = nil
        self.removeFromSuperview()
    }
}
