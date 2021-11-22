//
//  WeatherViewController.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var tabbarViewController: UITabBarController = {
        let tabbarViewController = UITabBarController()
        
        //MARK: WeatherViewController
        let weatherNavigation = WeatherRouter.createWeatherModule()
        weatherNavigation.title = "Weather"
        weatherNavigation.tabBarItem.image = UIImage.init(systemName: "cloud.sun.fill")
        
        
        //MARK: WebViewController
        let webviewNavigation = WebViewRouter.createWebViewModule()
        webviewNavigation.title = "WebView"
        webviewNavigation.tabBarItem.image = UIImage.init(systemName: "cursorarrow.click")
        
        //TODO: 
        tabbarViewController.setViewControllers([weatherNavigation, webviewNavigation], animated: true)
        tabbarViewController.selectedIndex = 0
        tabbarViewController.tabBar.tintColor = .black
        tabbarViewController.tabBar.backgroundColor = .white
        return tabbarViewController
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbarViewController
        window?.makeKeyAndVisible()
        return true
    }
}

