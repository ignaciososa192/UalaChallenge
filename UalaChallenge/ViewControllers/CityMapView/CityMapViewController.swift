//
//  CityMapViewController.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import UIKit
import SwiftUI
import MapKit

class CityMapViewController: UIViewController {
    private let city: City
    private weak var coordinator: CityMapCoordinator?
    
    init(city: City, coordinator: CityMapCoordinator) {
        self.city = city
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(city.name), \(city.country)"
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        
        let mapView = CityMapView(city: city)
        
        let content = VStack {
            mapView
                .frame(height: 300)
            Button("Ver detalle") {
                self.coordinator?.showDetail(from: self, for: self.city)
            }
            .padding()
        }
        
        let hosting = UIHostingController(rootView: content)
        addChild(hosting)
        view.addSubview(hosting.view)
        
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hosting.didMove(toParent: self)
    }
}
