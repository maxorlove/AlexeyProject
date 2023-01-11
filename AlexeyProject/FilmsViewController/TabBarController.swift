//
//  FilmsProfileTabBarController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Properties
    let filmsTabBarItem = UITabBarItem()
    let filmsViewController = UINavigationController(rootViewController: FilmsViewController())
    let profileViewController = UINavigationController(rootViewController: ProfileInfoViewController())
    let profileBarItem = UITabBarItem()
   
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
    
    //MARK: - Methods
    private func setup() {
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        
        filmsTabBarItem.title = "Films"
        filmsTabBarItem.image = UIImage(systemName: "film.fill")
        
        profileBarItem.title = "Profile"
        profileBarItem.image = UIImage(systemName: "person.fill")
    }
}
