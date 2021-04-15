//
//  RestaurantViewController.swift
//  ChowList
//
//  Created by Jon on 4/13/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RestaurantsViewModelDelegate {
    var model = RestaurantsViewModel()

    let restaurantsTableView = UITableView()
    let restaurantCellIdentifier = "RestaurantCell"

    override func loadView() {
        super.loadView()
        setupTableView()
        setupNavigationBar()
        model.delegate = self
        model.updateModel()
    }

    func setupTableView() {
        restaurantsTableView.translatesAutoresizingMaskIntoConstraints = false
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        restaurantsTableView.register(UITableViewCell.self, forCellReuseIdentifier: restaurantCellIdentifier)
        restaurantsTableView.backgroundColor = UIColor(named: "goji-berry")
        view.addSubview(restaurantsTableView)

        NSLayoutConstraint.activate([
            restaurantsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            restaurantsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            restaurantsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            restaurantsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        view.backgroundColor = UIColor(named: "goji-berry")
    }

    func setupNavigationBar() {
        navigationItem.title = "Restaurants"
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "goji-berry")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "goji-berry")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "squid-ink") ?? UIColor.black
        ]
    }

    // MARK: - UITableViewDataSoure and Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: restaurantCellIdentifier, for: indexPath)
        cell.textLabel?.text = model.restaurants[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RestaurantDetailView(model: model.restaurants[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - RestaurantsViewModelDelegate method
    func didLoadData() {
        DispatchQueue.main.async {
            self.restaurantsTableView.reloadData()
        }
    }

}

