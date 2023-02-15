//
//  FilmsProfileTabBarController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Private Properties
    private let filmsTabBarItem = UITabBarItem()
    private let filmsViewController = UINavigationController(rootViewController: FilmsAssembly.build())
    private let profileViewController = UINavigationController(rootViewController: ProfileAssembly.build())
    private let profileBarItem = UITabBarItem()
   
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filmsViewController.tabBarItem = filmsTabBarItem
        profileViewController.tabBarItem = profileBarItem
        self.viewControllers = [filmsViewController, profileViewController]
    }
    
    //MARK: - Private Methods
    private func setup() {
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = Colors.primaryBackGroundColor
        tabBar.tintColor = Colors.accentSurfaceColor
        tabBar.unselectedItemTintColor = Colors.primaryTextOnBackGroundColor
        tabBar.itemPositioning = .fill
        
        filmsTabBarItem.title = ""
        filmsTabBarItem.image = UIImage(named: "icoCompass")
        filmsTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 96.25, bottom: 0, right: 78)
        
        profileBarItem.title = ""
        profileBarItem.image = UIImage(named: "shape")
        profileBarItem.imageInsets = UIEdgeInsets(top: 0, left: 78, bottom: 0, right: 96.25)
    }
}
