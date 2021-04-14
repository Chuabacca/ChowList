//
//  RestaurantsViewModel.swift
//  ChowList
//
//  Created by Jon on 4/14/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import Foundation

class RestaurantsViewModel {
    let service = RestaurantsService.shared
    var delegate: RestaurantsViewModelDelegate?

    var restaurants: [Restaurant] = []
    struct Restaurant {
        let name: String
        let address: String
        let latitude: Double
        let longitude: Double
    }

    func updateModel() {
        service.getRestaurants() { [weak self] restaurantData in
            for restaurant in restaurantData.locations {
                let restaurant = Restaurant(
                    name: restaurant.name,
                    address: restaurant.address.addressString,
                    latitude: restaurant.address.latitude,
                    longitude: restaurant.address.longitude
                )
                self?.restaurants.append(restaurant)
            }
            self?.delegate?.didLoadData()
            print(self?.restaurants.description)
        }
    }
}

protocol RestaurantsViewModelDelegate {
    func didLoadData()
}
