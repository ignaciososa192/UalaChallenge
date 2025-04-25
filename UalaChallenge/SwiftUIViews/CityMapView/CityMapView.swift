//
//  CityMapView.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 25/04/2025.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    let city: City
    @State private var region: MKCoordinateRegion
    
    init(city: City) {
        self.city = city
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [city]) { city in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon), tint: .blue)
        }
    }
}

struct CityMapView_Previews: PreviewProvider {
    static var previews: some View {
        CityMapView(city: City(
            _id: 123,
            name: "Buenos Aires",
            country: "AR",
            coord: .init(lat: -34.6037, lon: -58.3816)
        ))
        .previewDisplayName("Buenos Aires Map")
    }
}
