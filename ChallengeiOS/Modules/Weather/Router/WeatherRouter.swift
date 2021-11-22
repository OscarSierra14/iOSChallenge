//
//  WeatherRouter.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class WeatherRouter: WeatherRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createWeatherModule() -> WeatherViewController {
        let ref = WeatherViewController.instantiate(from: .weather)
        let presenter: WeatherPresenterProtocol & WeatherInteractorOutputProtocol = WeatherPresenter()
        let router = WeatherRouter()
        router.viewController = ref
        let interactor = WeatherInteractor()
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

