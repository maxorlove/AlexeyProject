//
//  ProfileViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 09.01.2023.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func changingInfo(profile: Profile)
}

class ProfileInfoViewController: UIViewController {
    
    // MARK: - Properties
   private let infoStackView = UIStackView()
   private let nameView = NameView()
   private let emailView = EmailView()
   private let userAvatarImage = UIImageView()
    
   private let changeButton = UIButton()
    var profile: Profile = .init(
        name: UserDefaults.standard.string(forKey: "name") ?? "",
        email: UserDefaults.standard.string(forKey: "email") ?? "",
        photo: UIImage(named: "noneAvatar")
        )
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf(profile: profile)
        setup()
    }
    
    // MARK: - Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupNavBar()
        setupImageView()
        setupButton()
        setupStackView()
    }
    
    private func addSubviews() {
        view.addSubview(infoStackView)
        view.addSubview(userAvatarImage)
        view.addSubview(changeButton)
    }
    
    private func setupConstraints() {
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        userAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userAvatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userAvatarImage.heightAnchor.constraint(equalToConstant: 180),
            userAvatarImage.widthAnchor.constraint(equalToConstant: 180),
            
            infoStackView.topAnchor.constraint(equalTo: userAvatarImage.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupNavBar() {
        navigationItem.title = "Profile"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 54)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.primaryTextOnSurfaceColor ?? .white]
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: changeButton)
    }
    
    private func setupStackView() {
        view.backgroundColor = Colors.primaryBackGroundColor
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.alignment = .fill
        infoStackView.spacing = 8
        
        infoStackView.addArrangedSubview(nameView)
        infoStackView.addArrangedSubview(emailView)
    }
    
    private func setupImageView() {
        userAvatarImage.contentMode = .scaleAspectFill
        userAvatarImage.layer.cornerRadius = 90
        userAvatarImage.layer.masksToBounds = true
    }
    
    private func setupButton() {
        changeButton.setImage(UIImage(systemName: "pencil.line"), for: [])
        changeButton.contentMode = .scaleAspectFit
        changeButton.tintColor = .systemRed
        changeButton.addTarget(self, action: #selector(changeProfile), for: .touchUpInside)
    }
    
    func configureSelf(profile: Profile) {
        nameView.nameText.text = profile.name
        emailView.emailText.text = profile.email
        if let imageData = UserDefaults.standard.object(forKey: "photo") as? Data {
            profile.photo = UIImage(data: imageData)
            userAvatarImage.image = profile.photo
        } else {
            userAvatarImage.image = profile.photo
        }
    }
}
    
    // MARK: - Routing
extension ProfileInfoViewController {
    @objc func changeProfile(sender: UIButton) {
        let controller = ChangeProfileInfoViewController()
        controller.profile = profile
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileInfoViewController: ProfileViewDelegate {
    func changingInfo(profile: Profile) {
        nameView.nameText.text = UserDefaults.standard.string(forKey: "name")
        emailView.emailText.text = UserDefaults.standard.string(forKey: "email")
        if let imageData = UserDefaults.standard.object(forKey: "photo") as? Data {
            userAvatarImage.image = UIImage(data: imageData)
        }
    }
}









