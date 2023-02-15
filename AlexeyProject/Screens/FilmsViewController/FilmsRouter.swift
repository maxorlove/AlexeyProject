//
//  FilmsRouter.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 02.02.2023.
//

import UIKit
import Foundation

protocol FilmsRouterProtocol: AnyObject {
    
    //MARK: - Public Methods
    func showFilmView(film: Film, likePressed: @escaping () -> Void)
}

final class FilmsRouter {
    
    //MARK: - Public Properties
    weak var viewController: UIViewController?
    
    //MARK: - Init
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

//MARK: - FilmsRouterProtocol
extension FilmsRouter: FilmsRouterProtocol {
    func showFilmView(film: Film, likePressed: @escaping () -> Void) {
        let controller = FilmAssembly.build(id: film.id, likePressed: likePressed)
        viewController?.navigationController?.pushViewController(controller, animated: true)

    }
}
