//
//  WebViewProtocols.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

protocol WebViewInteractorProtocol: AnyObject {
    var presenter: WebViewInteractorOutputProtocol? { get set }
}

protocol WebViewPresenterProtocol: AnyObject {
    var model: String? { get set }
    var view: WebViewViewProtocol? { get set }
    var router: WebViewRouterProtocol? { get set }
    var interactor: WebViewInteractorProtocol? { get set }
    func viewDidLoad()
}

protocol WebViewInteractorOutputProtocol: AnyObject {
    //TODO: Put here all service response (Failure and Success)
}

protocol WebViewRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    static func createWebViewModule() -> WebViewViewController
    func showAlert(with error: String)
}

protocol WebViewViewProtocol: AnyObject {
    var presenter: WebViewPresenterProtocol? { get set }
    func loadWebView(request: URLRequest)
}
