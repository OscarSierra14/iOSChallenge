//
//  WebViewRouter.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class WebViewRouter: WebViewRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createWebViewModule() -> WebViewViewController {
        let ref = WebViewViewController.instantiate(from: .webView)
        let presenter: WebViewPresenterProtocol & WebViewInteractorOutputProtocol = WebViewPresenter()
        let router = WebViewRouter()
        router.viewController = ref
        let interactor = WebViewInteractor()
        interactor.presenter = presenter
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        ref.presenter = presenter
        return ref
    }
    
    func showAlert(with error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

