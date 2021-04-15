//
//  RestaurantsService.swift
//  ChowList
//
//  Created by Jon on 4/13/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class RestaurantsService {
    // Only a single instance of the service is needed to call the API and decode JSON
    static let shared = RestaurantsService()
    private let restauratsAPI = URL(string: "https://api.chownow.com/api/company/1")!

    struct RestaurantData: Codable {
        var locations: [Restaurant]
        struct Restaurant: Codable {
            var address: Address
            struct Address: Codable {
                var addressString: String
                var latitude: Double
                var longitude: Double
                enum CodingKeys: String, CodingKey {
                    case addressString = "formatted_address"
                    case latitude
                    case longitude
                }
            }
            var name: String
        }
    }

    init() {}

    func getRestaurants(_ completion: @escaping (_ restaurantData: RestaurantData) -> Void) {
        let task = URLSession.shared.dataTask(with: restauratsAPI) { data, response, error in
            if let error = error {
                // A production app should use error logging and automated monitoring
                // so that problems with the API can be detected and mitigated.
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
            self.decodeJSON(data, completion)
        }
        task.resume()
    }

    // Separate diferent responsibilities into distinct functions
    private func decodeJSON(_ data: Data, _ completion: (_ restaurantData: RestaurantData) -> Void) -> Void {
        do {
            let decoder = JSONDecoder()
            let restaurantData = try decoder.decode(RestaurantData.self, from: data)
            completion(restaurantData)
        } catch {
            print("Handle JSON decoding error: \(error)")
        }
    }

}
