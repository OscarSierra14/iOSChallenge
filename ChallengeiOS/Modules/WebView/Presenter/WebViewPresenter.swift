//
//  WebViewPresenter.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class WebViewPresenter: WebViewPresenterProtocol {
    var model: String?
    weak var view: WebViewViewProtocol?
    var router: WebViewRouterProtocol?
    var interactor: WebViewInteractorProtocol?
    
    func viewDidLoad() {
        guard let link = URL(string:"https://www.cyamoda.com/")
        else {
            return
        }

        let request = URLRequest(url: link)
        view?.loadWebView(request: request)
    }
}

extension WebViewPresenter: WebViewInteractorOutputProtocol { 
}
