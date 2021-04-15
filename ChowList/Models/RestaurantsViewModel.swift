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
    // This Restaurant struct will be passed to the detail views
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
            // Debugging. A full production app can use dependency injection to mock the service
            // and test that the model is formatting and storing data correctly.
            print(self?.restaurants.description ?? "Model is empty.")
        }
    }
}

// The protocol/delegate pattern can be changed to notification/observer pattern if multiple views
// are relying on this model for data.
protocol RestaurantsViewModelDelegate {
    func didLoadData()
}
