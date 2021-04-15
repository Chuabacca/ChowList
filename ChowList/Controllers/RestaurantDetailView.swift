//
//  RestaurantDetailView.swift
//  ChowList
//
//  Created by Jon on 4/14/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class RestaurantDetailView: UIViewController {
    var model: RestaurantsViewModel.Restaurant

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ model: RestaurantsViewModel.Restaurant) {
        super.init()
    }
}
