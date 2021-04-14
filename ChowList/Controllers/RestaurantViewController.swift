//
//  RestaurantViewController.swift
//  ChowList
//
//  Created by Jon on 4/13/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UITableViewDataSource {
    var model = RestaurantsViewModel()

    let restaurantsTableView = UITableView()
    let restaurantCellIdentifier = "RestaurantCell"

    override func loadView() {
        super.loadView()
        setupTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        model.updateModel()
    }

    func setupTableView() {
        restaurantsTableView.translatesAutoresizingMaskIntoConstraints = false
        restaurantsTableView.dataSource = self
        restaurantsTableView.register(UITableViewCell.self, forCellReuseIdentifier: restaurantCellIdentifier)
        view.addSubview(restaurantsTableView)

        NSLayoutConstraint.activate([
            restaurantsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            restaurantsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            restaurantsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            restaurantsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        view.backgroundColor = .cyan
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: restaurantCellIdentifier, for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }

}

