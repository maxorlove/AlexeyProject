//
//  FilmsAssembly.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 31.01.2023.
//

import UIKit

final class FilmsAssembly {
    
    static func build() -> UIViewController {
        let network = NetworkService()
        let view = FilmsViewController()
        let router = FilmsRouter(viewController: view)
        let presenter = FilmsPresenter(
            controller: view,
            networkClient: network,
            router: router
        )
        view.presenter = presenter
        return view
    }
}
