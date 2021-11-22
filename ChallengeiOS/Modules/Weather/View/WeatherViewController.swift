//
//  WeatherViewController.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class WeatherViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var tableView: UITableView!
    var dataTableView: [WheatherDataTableView] = []
    var presenter: WeatherPresenterProtocol?
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Refresh Control for tableView
        refreshControl.addTarget(self, action: #selector(loadPresenterViewLoad), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        loadPresenterViewLoad()
        setupTableView()
    }

    @objc
    func loadPresenterViewLoad() {
        showLoaderLottie(.normal)
        presenter?.viewDidLoad()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeatherInformationCellView.self, forCellReuseIdentifier: WeatherInformationCellView.viewID)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableView = tableView.dequeueReusableCell(withIdentifier: WeatherInformationCellView.viewID, for: indexPath)
        guard let cell = tableView as? WeatherInformationCellView else { return tableView }
        cell.setup(data: dataTableView[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTableView.count
    }
}

extension WeatherViewController: WeatherViewProtocol {
    func displayWetherInformation(data: [WheatherDataTableView]) {
        dataTableView = data
        tableView.reloadData()
        hideLoaderLottie()
        refreshControl.endRefreshing()
    }
}
