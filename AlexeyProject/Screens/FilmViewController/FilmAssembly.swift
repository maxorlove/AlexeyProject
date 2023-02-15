//
//  FilmAssembly.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 03.02.2023.
//

import UIKit

final class FilmAssembly {
    
    static func build(id: Int, likePressed: @escaping () -> Void) -> UIViewController {
        let network = NetworkService()
        let view = FilmViewController()
        let router = FilmRouter(viewController: view)
        let presenter = FilmPresenter(
            controller: view,
            networkClient: network,
            router: router,
            likePressed: likePressed,
            filmId: id
        )
        view.presenter = presenter
        return view
    }
}
