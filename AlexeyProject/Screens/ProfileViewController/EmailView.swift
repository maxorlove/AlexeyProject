//
//  EmailView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 09.01.2023.
//

import UIKit

class EmailView: UIView {
    
    //MARK: - Properties
    let emailLabel = UILabel()
    let emailText = UILabel()
    
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
        setupLabel()
    }
    
    private func addSubviews() {
        addSubview(emailLabel)
        addSubview(emailText)
    }
    
    private func setupConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            emailText.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            emailText.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailText.trailingAnchor.constraint(equalTo: trailingAnchor),
            emailText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func setupLabel() {
        emailLabel.text = "Email"
        emailLabel.textColor = Colors.primaryTextOnSurfaceColor
        emailLabel.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        emailLabel.textAlignment = .left
        
        emailText.textColor = Colors.secondarySurfaceColor
        emailText.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        emailText.textAlignment = .left
    }
}

