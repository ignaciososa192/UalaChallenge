//
//  CityService.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 25/04/2025.
//

import Foundation

enum DataSource {
    case local
    case remote
    case hybrid // Intenta remoto primero, si falla usa local
}

class CityService {
    private let source: DataSource
    
    init(source: DataSource) {
        self.source = source
    }
    
    func getCities(completion: @escaping ([City]) -> Void) {
        switch source {
        case .local:
            loadLocalCities(completion: completion)
        case .remote:
            loadRemoteCities(completion: completion)
        case .hybrid:
            loadRemoteCities { cities in
                if cities.isEmpty {
                    // Si la carga remota falla, usamos la local como respaldo
                    print("Remote loading failed, falling back to local data")
                    self.loadLocalCities(completion: completion)
                } else {
                    completion(cities)
                }
            }
        }
    }
    
    private func loadLocalCities(completion: @escaping ([City]) -> Void) {
        // Primero intentamos cargar "Cities.json" (como mencionaste)
        if let url = Bundle.main.url(forResource: "Cities", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            parseData(data, completion: completion)
            return
        }
        
        // Si no encuentra "Cities.json", intentamos "cities.json" (con minúscula)
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            parseData(data, completion: completion)
            return
        }
        
        // Si ninguno funciona, mostramos error y enviamos lista vacía
        print("Error: No se pudo encontrar el archivo JSON de ciudades en el bundle")
        completion([])
    }
    
    private func loadRemoteCities(completion: @escaping ([City]) -> Void) {
        let urlString = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
        
        guard let url = URL(string: urlString) else {
            print("Error: URL inválida")
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error en la respuesta del servidor")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos")
                completion([])
                return
            }

            DispatchQueue.main.async {
                self.parseData(data, completion: completion)
            }
        }
        
        task.resume()
    }
    
    private func parseData(_ data: Data, completion: @escaping ([City]) -> Void) {
        do {
            let cities = try JSONDecoder().decode([City].self, from: data)
            let sortedCities = cities.sorted { $0.name < $1.name }
            completion(sortedCities)
        } catch {
            print("Error decodificando ciudades: \(error)")
            completion([])
        }
    }
}
