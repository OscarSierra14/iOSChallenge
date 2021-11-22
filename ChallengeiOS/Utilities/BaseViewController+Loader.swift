//
//  BaseViewController.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

enum LoaderStyle: Equatable {
    case normal
}

protocol BaseLoadingViewProtocol: AnyObject {
    func showLoaderLottie(_ style: LoaderStyle)
    func hideLoaderLottie()
    func removeBaseAlert()
}

extension BaseViewController: BaseLoadingViewProtocol {
    
    func showLoaderLottie(_ style: LoaderStyle) {
        if let first = self.view.subviews.first(where: { $0 === self.loaderLottie.self }) as? LoaderLottie {
            first.showAnimation(style)
            return
        }
        
        view.addSubview(loaderLottie)
        loaderLottie.translatesAutoresizingMaskIntoConstraints = false
        loaderLottie.equalBoundsTo(view: view)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            UIView.animate(withDuration: 0.2, animations: {
                self?.loaderLottie.showAnimation(style)
            })
        }
    }
    
    func hideLoaderLottie() {
        let filteredArray = view.subviews.filter { $0 is LoaderLottie }
        if let loaderLottie = filteredArray.first as? LoaderLottie {
            UIView.animate(withDuration: 0.3, animations: {
                loaderLottie.alpha = 0
            }) { (finished) in
                loaderLottie.alpha = 1
                loaderLottie.hideAnimation()
            }
        }
    }
}
