//
//  PrifileViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import UIKit

class ChangeProfileInfoViewController: UIViewController {
    
    // MARK: - Private Properties
    private let infoChangeStackView = UIStackView()
    private let nameView = ChangeInfoView()
    private let emailView = ChangeEmailView()
    private let changeAvatarImageButton = UIButton()
    private let saveButton = UIButton()
    
    // MARK: - Private Properties
    var profile: Profile?
    weak var delegate: ProfileViewDelegate?
    var activeTextField : UITextField?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeProfileInfoViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeProfileInfoViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        configureSelf()
        setup()
        delegateTextField()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupNavBar()
        setupImageView()
        setupButton()
        setupStackView()
    }
    
    func configureSelf() {
        nameView.nameTextField.text = UserDefaults.standard.string(forKey: "name")
        emailView.emailTextField.text = UserDefaults.standard.string(forKey: "email")
        
        if let imageData = UserDefaults.standard.object(forKey: "photo") as? Data {
            changeAvatarImageButton.setImage(UIImage(data: imageData), for: [])
        } else {
            changeAvatarImageButton.setImage(profile?.photo, for: [])
        }
    }
    
    private func addSubviews() {
        view.addSubview(infoChangeStackView)
        view.addSubview(changeAvatarImageButton)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        infoChangeStackView.translatesAutoresizingMaskIntoConstraints = false
        changeAvatarImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeAvatarImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            changeAvatarImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeAvatarImageButton.heightAnchor.constraint(equalToConstant: 180),
            changeAvatarImageButton.widthAnchor.constraint(equalToConstant: 180),
            
            infoChangeStackView.topAnchor.constraint(equalTo: changeAvatarImageButton.bottomAnchor, constant: 10),
            infoChangeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoChangeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupNavBar() {
        navigationItem.title = "Edit Profile"
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 54)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.primaryTextOnSurfaceColor ?? .white]
        navigationController?.navigationBar.backgroundColor = Colors.primaryBackGroundColor
        navigationController?.navigationBar.tintColor = Colors.primaryTextOnSurfaceColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    private func setupStackView() {
        view.backgroundColor = Colors.primaryBackGroundColor
        infoChangeStackView.axis = .vertical
        infoChangeStackView.distribution = .fillEqually
        infoChangeStackView.alignment = .fill
        infoChangeStackView.spacing = 8
        
        infoChangeStackView.addArrangedSubview(nameView)
        infoChangeStackView.addArrangedSubview(emailView)
    }
        
    private func setupImageView() {
        changeAvatarImageButton.contentMode = .scaleAspectFill
        changeAvatarImageButton.layer.cornerRadius = 90
        changeAvatarImageButton.layer.masksToBounds = true
        changeAvatarImageButton.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
    }
    
    private func setupButton() {
        saveButton.setImage(UIImage(systemName: "checkmark"), for: [])
        saveButton.contentMode = .scaleAspectFit
        saveButton.tintColor = .systemGreen
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
    }
    
    private func delegateTextField() {
        nameView.nameTextField.delegate = self
        emailView.emailTextField.delegate = self
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
        
        var shouldMoveViewUp = false
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if shouldMoveViewUp {
            self.view.frame.origin.y = 0 - 100
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ChangeProfileInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let dataImage = image.pngData() as? NSData
            UserDefaults.standard.set(dataImage, forKey: "photo")            
            self.changeAvatarImageButton.setImage(image, for: [])
        } else if let image = info[.editedImage] as? UIImage {
            let dataImage = image.pngData() as? NSData
            UserDefaults.standard.set(dataImage, forKey: "photo")
            self.changeAvatarImageButton.setImage(image, for: [])
        }
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension ChangeProfileInfoViewController: UITextFieldDelegate {
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}

