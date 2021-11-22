//
//  BaseViewController.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Storyboarded {
    let backgroundImageView = UIImageView()
    var loaderLottie = LoaderLottie()
    var userDefaultsManager: UserDefaultsManagerProtocol?
    var isToastShowing = false
    let baseAlertViewController = BaseAlertViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         NotificationCenter.default.setObserver(self, selector: #selector(BaseViewController.conectionInternetFailed(notification:)), name: Notification.Name(ThirdPartyConstants.NotificationCenter.internetConnectionFailed), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool)  {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name(ThirdPartyConstants.NotificationCenter.internetConnectionFailed),
            object: nil)
    }

    @objc func conectionInternetFailed(notification: Notification) {
        self.hideLoaderLottie()
        addBaseAlert(type: .network)
    }

    func removeBaseAlert() {
        guard let alertView = view.subviews.first(where: { $0 is BaseAlertView }) as? BaseAlertView else {
            return
        }

        alertView.remove()
    }

    func addBaseAlert(type: BaseAlertType) {
        guard view.subviews.filter({ $0 is BaseAlertView }).isEmpty else {
            return
        }

        let baseAlertViewController = BaseAlertView(alertType: type)
        view.addSubview(baseAlertViewController)
        baseAlertViewController.equalBoundsTo(view: view)
        self.hideLoaderLottie()
    }

    func addTransition(_ subType: CATransitionSubtype, duration: CFTimeInterval = 0.5) {
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.moveIn
        transition.subtype = subType
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
    }
    
    func presentBaseAlert(labels: [UILabel], completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            if self?.view.subviews.first(where: { $0 === self?.baseAlertViewController.self}) as? BaseAlertViewController == nil {
                self?.addBaseAlertViewController()
            }
            self?.baseAlertViewController.setup(labels: labels)
        }
    }
    
    private func addBaseAlertViewController() {
        DispatchQueue.main.async { [weak self] in
            self?.view.addSubview(self?.baseAlertViewController ?? BaseAlertViewController())
            self?.baseAlertViewController.translatesAutoresizingMaskIntoConstraints = false
            self?.baseAlertViewController.equalBoundsTo(view: self?.view ?? UIView())
        }
    }

}

extension NotificationCenter {
    func setObserver(_ observer: AnyObject, selector: Selector, name: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}

extension NSObject {
    func safeRemoveObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        switch self.observationInfo {
        case .some:
            self.removeObserver(observer, forKeyPath: keyPath)
        default:
            debugPrint("observer does no not exist")
        }
    }
}
