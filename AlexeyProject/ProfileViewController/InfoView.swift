//
//  InfoView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 06.01.2023.
//

import UIKit

class InfoView: UIView {
    
    //MARK: - Properties
    let nameLabel = UILabel()
    let nameText = UILabel()
    
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
        addSubview(nameLabel)
        addSubview(nameText)
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            nameText.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameText.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func setupLabel() {
        nameLabel.text = "Name"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        nameLabel.textAlignment = .left
        
        nameText.textColor = .black
        nameText.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nameText.textAlignment = .left
    }
}
