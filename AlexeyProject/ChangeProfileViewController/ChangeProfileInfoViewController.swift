//
//  PrifileViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import UIKit

class ChangeProfileInfoViewController: UIViewController {
    
    // MARK: - Properties
    let infoChangeStackView = UIStackView()
    let nameView = ChangeInfoView()
    let emailView = ChangeEmailView()

    let changeAvatarImage = UIButton()
    let saveButton = UIButton()
    
    var profile: Profile?
    weak var delegate: ProfileViewDelegate?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeProfileInfoViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeProfileInfoViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(infoChangeStackView)
        view.addSubview(changeAvatarImage)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        infoChangeStackView.translatesAutoresizingMaskIntoConstraints = false
        changeAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeAvatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 127),
            changeAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeAvatarImage.heightAnchor.constraint(equalToConstant: 128),
            changeAvatarImage.widthAnchor.constraint(equalToConstant: 128),
            
            infoChangeStackView.topAnchor.constraint(equalTo: changeAvatarImage.bottomAnchor, constant: 20),
            infoChangeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoChangeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupNavBar() {
        title = "Edit Profile"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    private func setupStackView() {
        infoChangeStackView.axis = .vertical
        infoChangeStackView.distribution = .fillEqually
        infoChangeStackView.alignment = .fill
        infoChangeStackView.spacing = 8
        
        infoChangeStackView.addArrangedSubview(nameView)
        infoChangeStackView.addArrangedSubview(emailView)
    }
        
    private func setupImageView() {
        changeAvatarImage.contentMode = .scaleAspectFill
        changeAvatarImage.layer.cornerRadius = 10
        changeAvatarImage.layer.masksToBounds = true
        changeAvatarImage.setImage((profile?.photo), for: [])
        changeAvatarImage.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
    }
    
    private func setupButton() {
        saveButton.setImage(UIImage(systemName: "checkmark"), for: [])
        saveButton.contentMode = .scaleAspectFit
        saveButton.tintColor = .systemGreen
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
    }
    
    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    private func showImagePickerOptions() {
        let alert = UIAlertController(title: "Pick a Photo", message: "Choose a picture from Library or Camera", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {[weak self] (action) in
            guard let self = self else {
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.present(cameraImagePicker, animated: true)
        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) {[ weak self] (action) in
            guard let self = self else {
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addInfo() {
        if let nameInfo = nameView.nameTextField.text {
            UserDefaults.standard.set(nameInfo, forKey: "name")
        }
        
        if let emailInfo = emailView.emailTextField.text {
            UserDefaults.standard.set(emailInfo, forKey: "email")
        }
        if let unwrappedProfile = profile {
            delegate?.changingInfo(profile: unwrappedProfile)
        }
    }
    
    @objc func saveProfile(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        addInfo()
    }
    
    @objc func changeImage(sender: UIButton) {
        showImagePickerOptions()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ChangeProfileInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = (info[.originalImage] as? UIImage) {
            self.changeAvatarImage.setImage(image, for: [])
        } else if let image = info[.editedImage] as? UIImage {
            self.changeAvatarImage.setImage(image, for: [])
        }
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


