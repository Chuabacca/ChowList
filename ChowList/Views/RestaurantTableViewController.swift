//
//  RestaurantTableViewController.swift
//  ChowList
//
//  Created by Jon on 4/13/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let service = RestaurantsService()
        service.getRestaurants()
    }


}

