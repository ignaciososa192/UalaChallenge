//
//  AppCoordinator.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Foundation
import UIKit

/// Coordinador raíz de la app
protocol AppCoordinator {
    var window: UIWindow { get }
    func start()
}

/// Navegación desde la pantalla de lista
protocol CityListCoordinator: AnyObject {
    func showMap(for city: City)
    func showDetail(for city: City)
}

/// Navegación desde la pantalla de mapa
protocol CityMapCoordinator: AnyObject {
    func showDetail(from mapVC: CityMapViewController, for city: City)
}

final class Coordinator: AppCoordinator,
                         CityListCoordinator,
                         CityMapCoordinator {
    let window: UIWindow
    private let nav = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - AppCoordinator
    func start() {
        let listVC = CityListViewController(coordinator: self)
        nav.viewControllers = [listVC]
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    // MARK: - CityListCoordinator
    func showMap(for city: City) {
        let mapVC = CityMapViewController(city: city, coordinator: self)
        nav.pushViewController(mapVC, animated: true)
    }

    func showDetail(for city: City) {
        let detailVC = CityDetailViewController(city: city)
        nav.pushViewController(detailVC, animated: true)
    }

    // MARK: - CityMapCoordinator
    func showDetail(from mapVC: CityMapViewController, for city: City) {
        let detailVC = CityDetailViewController(city: city)
        nav.pushViewController(detailVC, animated: true)
    }
}
