//
//  RestaurantDetailViewController.swift
//  ChowList
//
//  Created by Jon on 4/14/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController {
    var model: RestaurantsViewModel.Restaurant

    let nameLabel = UILabel()
    let mapView = MKMapView()
    let addressLabel = UILabel()

    init(model: RestaurantsViewModel.Restaurant) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        view.backgroundColor = .white

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        addressLabel.textColor = UIColor(named: "squid-ink")
        nameLabel.text = model.name
        view.addSubview(nameLabel)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        let center = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        mapView.addAnnotation(pin)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
        view.addSubview(mapView)

        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.numberOfLines = 0
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = UIColor(named: "squid-ink")
        addressLabel.text = model.address
        view.addSubview(addressLabel)

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            mapView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            addressLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            addressLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
