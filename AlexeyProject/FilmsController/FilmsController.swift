//
//  FilmsProfileTabBarController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import UIKit

class FilmsController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Properties
    let filmsTab = File()
    let filmsTabBarItem = UITabBarItem()
    let profileTab = ProfileInfoViewController()
    let profileBarItem = UITabBarItem()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filmsTab.tabBarItem = filmsTabBarItem
        profileTab.tabBarItem = profileBarItem
        self.viewControllers = [filmsTab, profileTab]
    }
    
    //MARK: - Methods
    private func setup() {
        setupTabBar()
        setupNavBar()
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
    
    private func setupNavBar() {
        view.backgroundColor = .red
        title = "Films"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
