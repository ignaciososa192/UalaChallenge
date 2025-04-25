//
//  CityListView.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var viewModel: CityListViewModel
    @State private var filter: String = ""
    @State private var showingFavoritesOnly = false
    @FocusState private var isSearchFieldFocused: Bool
    
    let showOnMap: (City) -> Void
    let showInfo: (City) -> Void
    
    // Definimos el layout de columnas para la grid
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Cities")
                .contentShape(Rectangle())
                .onTapGesture {
                    isSearchFieldFocused = false
                }
        }
    }
    
    var content: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading cities...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            } else {
                VStack {
                    TextField("Filter your city", text: $filter)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: filter) { newValue in
                            viewModel.filter = newValue
                        }
                        .focused($isSearchFieldFocused)
                    
                    Toggle("Only favorites", isOn: $showingFavoritesOnly)
                        .padding([.leading, .trailing])
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(Array(filteredCities.enumerated()), id: \.element._id) { index, city in
                                CityRowView(
                                    city: city,
                                    isFavorite: viewModel.isFavorite(city),
                                    toggleFavorite: { viewModel.toggleFavorite(city) },
                                    onTap: { showOnMap(city) },
                                    infoAction: { showInfo(city) },
                                    isEven: index % 2 == 0 // << agregamos si es par
                                )
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentCity: city)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
    
    var filteredCities: [City] {
        let filtered = viewModel.results
        return showingFavoritesOnly
        ? filtered.filter { viewModel.isFavorite($0) }
        : filtered
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        // Creamos un ViewModel con datos pre-cargados
        let viewModel = CityListViewModel(service: MockCityService())
        
        // Pre-cargar datos manualmente
        viewModel.allCities = sampleCities
        
        // Marcar algunas como favoritas
        viewModel.toggleFavorite(sampleCities[0])
        viewModel.toggleFavorite(sampleCities[2])
        
        return CityListView(
            viewModel: viewModel,
            showOnMap: { _ in print("Show on map") },
            showInfo: { _ in print("Show info") }
        )
    }
    
    // Ciudades de ejemplo para la preview
    static var sampleCities: [City] = [
        City(_id: 1, name: "New York", country: "US", coord: Coordinate(lat: 40.7128, lon: -74.0060)),
        City(_id: 2, name: "London", country: "GB", coord: Coordinate(lat: 51.5074, lon: -0.1278)),
        City(_id: 3, name: "Tokyo", country: "JP", coord: Coordinate(lat: 35.6762, lon: 139.6503)),
        City(_id: 4, name: "Paris", country: "FR", coord: Coordinate(lat: 48.8566, lon: 2.3522)),
        City(_id: 5, name: "Sydney", country: "AU", coord: Coordinate(lat: -33.8688, lon: 151.2093))
    ]
}

// Un servicio mock simplificado
class MockCityService: CityService {
    override func getCities(completion: @escaping ([City]) -> Void) {
        // Devolver inmediatamente las ciudades de ejemplo
        completion(CityListView_Previews.sampleCities)
    }
    
    init() {
        super.init(source: .local)
    }
}
