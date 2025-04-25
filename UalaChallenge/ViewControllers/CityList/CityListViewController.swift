//
//  CityListViewController.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import UIKit
import SwiftUI

class CityListViewController: UIViewController {
    private weak var coordinator: CityListCoordinator?
    private var viewModel: CityListViewModel!
    private var hostingController: UIHostingController<CityListView>?
    
    // MARK: – Init
    init(coordinator: CityListCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.viewModel = CityListViewModel(
            service: CityService(source: .hybrid)
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHostingController()
        viewModel.loadInitialData() // Cargar después de configurar la UI
    }
    
    // MARK: – Setup SwiftUI Host
    private func setupHostingController() {
        // Creamos la vista SwiftUI, pasando el viewModel directamente
        let listView = CityListView(
            viewModel: viewModel,
            showOnMap: { [weak self] city in
                self?.coordinator?.showMap(for: city)
            },
            showInfo: { [weak self] city in
                self?.coordinator?.showDetail(for: city)
            }
        )
        
        let hosting = UIHostingController(rootView: listView)
        self.hostingController = hosting
        
        addChild(hosting)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hosting.view)
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        hosting.didMove(toParent: self)
    }
}
