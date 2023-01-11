//
//  InfoView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 06.01.2023.
//

import UIKit

class ChangeInfoView: UIView {
    
    //MARK: - Properties
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    
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
        addSubview(nameLabel)
        addSubview(nameTextField)
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func setupLabel() {
        nameLabel.text = "text your name"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.textAlignment = .left
    }
    
    private func setupTextFiled() {
        nameTextField.placeholder = "Your name"
        nameTextField.textAlignment = .left
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.contentVerticalAlignment = .center
        nameTextField.textColor = .blue
        nameTextField.font = UIFont.systemFont(ofSize: 30)
    }
}
