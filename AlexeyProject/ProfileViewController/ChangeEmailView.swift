//
//  EmailView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 06.01.2023.
//

import UIKit

class ChangeEmailView: UIView {
    
    //MARK: - Properties
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews()
        setupConstraints()
        setupTextFiled()
        setupLabel()
    }
    
    private func addSubviews() {
        addSubview(emailLabel)
        addSubview(emailTextField)
    }
    
    private func setupConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            emailTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func setupLabel() {
        emailLabel.text = "text your email"
        emailLabel.textColor = .black
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailLabel.textAlignment = .left
    }
    
    private func setupTextFiled() {
        emailTextField.placeholder = "Your email"
        emailTextField.text = UserDefaults.standard.string(forKey: "email")
        emailTextField.textAlignment = .left
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.contentVerticalAlignment = .center
        emailTextField.textColor = .blue
        emailTextField.font = UIFont.systemFont(ofSize: 30)
    }
}
