//
//  FilmRouter.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 05.02.2023.
//

import UIKit
import Foundation

protocol FilmRouterProtocol: AnyObject {
    
    //MARK: - Public Methods
    func showFilmsView()
}

final class FilmRouter {
    
    //MARK: - Public Methods
    weak var viewController: UIViewController?
    
    //MARK: - Init
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

//MARK: - FilmRouterProtocol
extension FilmRouter: FilmRouterProtocol {
    
    func showFilmsView() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
