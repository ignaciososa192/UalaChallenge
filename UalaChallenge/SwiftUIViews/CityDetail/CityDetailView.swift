//
//  CityDetailView.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import SwiftUI

struct CityDetailView: View {
    @ObservedObject var viewModel: CityDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "building.2")
                Text(viewModel.city.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            HStack {
                Image(systemName: "flag")
                Text("Country: \(viewModel.city.country)")
                    .font(.headline)
            }
            
            HStack {
                Image(systemName: "location")
                Text("Coordinates: \(viewModel.city.coord.lat), \(viewModel.city.coord.lon)")
                    .font(.subheadline)
            }
            
            Button(action: viewModel.toggleFavorite) {
                Label(viewModel.isFavorite ? "Remove from Favorites" : "Add to Favorites", systemImage: viewModel.isFavorite ? "star.fill" : "star")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isFavorite ? Color.yellow.opacity(0.2) : Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.city.name)
    }
}

struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailView(viewModel: CityDetailViewModel(
            city: City(
                _id: 1,
                name: "Denver",
                country: "US",
                coord: .init(lat: 39.74, lon: -104.99)
            ),
            isFavorite: false
        ))
    }
}
