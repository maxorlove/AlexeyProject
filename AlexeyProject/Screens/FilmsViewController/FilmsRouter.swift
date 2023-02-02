//
//  FilmsRouter.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 02.02.2023.
//

import UIKit
import Foundation

protocol FilmsRouterProtocol: AnyObject {
    func showFilmView(film: Film)
}

final class FilmsRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension FilmsRouter: FilmsRouterProtocol {
    
    func showFilmView(film: Film) {
        let controller = FilmViewController()
        controller.film = film
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
