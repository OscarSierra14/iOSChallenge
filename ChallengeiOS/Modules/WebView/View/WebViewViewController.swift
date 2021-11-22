//
//  WebViewViewController.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import WebKit

class WebViewViewController: BaseViewController, WKNavigationDelegate {
    @IBOutlet private weak var webView: WKWebView!
    var presenter: WebViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenterViewLoad()
        webView.navigationDelegate = self
    }
    
    func loadWebView(request: URLRequest) {
        webView.load(request)
    }
    
    func loadPresenterViewLoad() {
        presenter?.viewDidLoad()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoaderLottie()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoaderLottie(.normal)
    }
}

extension WebViewViewController: WebViewViewProtocol {
}
