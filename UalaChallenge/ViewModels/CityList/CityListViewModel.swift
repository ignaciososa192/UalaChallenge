//
//  CityListViewModel.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Combine
import SwiftUI

class CityListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var allCities: [City] = []
    @Published var filter: String = ""
    @Published var favorites: Set<Int> = FavoritesStore.ids
    @Published var isLoading = false
    
    // MARK: - Private
    private let batchSize = 100
    private var currentPage = 0
    private var fullCitiesList: [City] = []
    private var citySearch: CitySearch?
    private let service: CityService
    private let debouncer = Debouncer(delay: 0.3)
    private var cancellable: AnyCancellable?
    
    // MARK: - Init
    init(service: CityService) {
        self.service = service
        setupFilterSubscription()
        loadInitialData()
    }
    
    // MARK: - Setup Combine
    private func setupFilterSubscription() {
        cancellable = $filter
            .sink { [weak self] newFilter in
                self?.debouncer.schedule {
                    DispatchQueue.main.async {
                        self?.applyFilter()
                    }
                }
            }
    }
    
    // MARK: - Data Loading
    func loadInitialData() {
        isLoading = true
        service.getCities { [weak self] cities in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.fullCitiesList = cities.sorted { $0.name < $1.name }
                self.citySearch = CitySearch(cities: self.fullCitiesList)
                self.allCities.removeAll()
                self.currentPage = 0
                self.loadNextBatch()
                self.isLoading = false
            }
        }
    }

    func loadNextBatch() {
        let startIndex = currentPage * batchSize
        guard startIndex < fullCitiesList.count else { return }
        
        let endIndex = min(startIndex + batchSize, fullCitiesList.count)
        let nextBatch = Array(fullCitiesList[startIndex..<endIndex])
        allCities.append(contentsOf: nextBatch)
        currentPage += 1
    }
    
    func loadMoreIfNeeded(currentCity city: City) {
        let thresholdIndex = allCities.count - 20
        if let index = allCities.firstIndex(where: { $0._id == city._id }),
           index >= thresholdIndex {
            loadNextBatch()
        }
    }
    
    // MARK: - Filtering
    private func applyFilter() {
        guard let citySearch = citySearch else { return }
        
        if filter.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            allCities = Array(fullCitiesList.prefix(batchSize))
            currentPage = 1
        } else {
            allCities = citySearch.search(prefix: filter)
        }
    }
    
    // MARK: - Favorites
    func toggleFavorite(_ city: City) {
        if favorites.contains(city._id) {
            favorites.remove(city._id)
        } else {
            favorites.insert(city._id)
        }
        FavoritesStore.ids = favorites
    }
    
    func isFavorite(_ city: City) -> Bool {
        return favorites.contains(city._id)
    }
    
    // MARK: - Filtered Results for View
    var results: [City] {
        return allCities
    }
}
