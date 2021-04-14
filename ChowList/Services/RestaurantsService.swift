//
//  RestaurantsService.swift
//  ChowList
//
//  Created by Jon on 4/13/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class RestaurantsService {
    // Structure of data we need for the app
    var restaurants: [Restaurant] = []
    struct Restaurant {
        let name: String
        let address: String
        let latitude: Double
        let longitude: Double
    }

    // Structure of data from the API
    struct RestaurantData: Codable {
        var locations: [Restaurant]
        struct Restaurant: Codable {
            var address: Address
            struct Address: Codable {
                var addressString: String
                var latitude: Double
                var longitude: Double
                enum CodingKeys: String, CodingKey {
                    case addressString = "address_string"
                    case latitude
                    case longitude
                }
            }
            var name: String
        }
    }

    init() {}

    // hard code the url string for now
    let urlString = "https://api.chownow.com/api/company/1"

    func getRestaurants() {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Handle error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Handle server error: \(response.debugDescription)")
                return
            }
            guard let data = data else {
                print("Received no data from API.")
                return
            }
            self.decodeJSON(data)
        }
        task.resume()
    }

    // Separate diferent responsibilities into distinct functions
    func decodeJSON(_ data: Data) -> Void {
        do {
            let decoder = JSONDecoder()
            let restaurantData = try decoder.decode(RestaurantData.self, from: data)
            self.mapRestaurantData(restaurantData)
            print(self.restaurants.description)
        } catch {
            print("Handle JSON decoding error: \(error)")
        }
    }

    func mapRestaurantData(_ restaurantData: RestaurantData) -> Void {
        for restaurant in restaurantData.locations {
            let restaurant = Restaurant(
                name: restaurant.name,
                address: restaurant.address.addressString,
                latitude: restaurant.address.latitude,
                longitude: restaurant.address.longitude
            )
            restaurants.append(restaurant)
        }
    }
}
