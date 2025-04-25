//
//  CityRowView.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import SwiftUI

struct CityRowView: View {
    let city: City
    let isFavorite: Bool
    let toggleFavorite: () -> Void
    let onTap: () -> Void
    let infoAction: () -> Void
    let isEven: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(city.name), \(city.country)")
                    .font(.headline)
                Text("Lat: \(city.coord.lat), Lon: \(city.coord.lon)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            Button(action: infoAction) {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
        .background(isEven ? Color.white : Color(UIColor.systemGray6))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}

struct CityRowView_Previews: PreviewProvider {
    static var previews: some View {
        CityRowView(
            city: City(_id: 42, name: "Sydney", country: "AU", coord: Coordinate(lat: -33.8688, lon: 151.2093)),
            isFavorite: true,
            toggleFavorite: {},
            onTap: {},
            infoAction: {},
            isEven: false
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
